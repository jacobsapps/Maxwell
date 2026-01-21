---
name: sqlite-data-usage
description: Guidance for working with Point-Free SQLiteData in Maxwell (data layer, repositories, and future CloudKit sync). Use when implementing or reviewing persistence and SQLiteData models.
---

# SQLiteData Usage (Maxwell)

## Overview
SQLiteData is a SQLite-first data layer built on GRDB with Swift macros for schema modeling and property wrappers for reactive fetching. It is designed to mirror SwiftData ergonomics while adding first-class CloudKit sync and sharing support. Use this skill when you are implementing Maxwell persistence, repositories, or data modeling so the data layer remains CloudKit-ready without enabling entitlements yet.

## Sources
See `references/sqlite-data-sources.md` for the authoritative links used to build this guidance.

## Maxwell-specific constraints
- Local-only today: do not add CloudKit entitlements or config yet, but keep the schema and data layer compatible with CloudKit sync.
- Default to main-actor access; use @concurrent for background work when needed.

## Core concepts
- Database access is via GRDB's DatabaseWriter protocol, backed by DatabaseQueue (serial) or DatabasePool (concurrent).
- Schema modeling uses @Table on Swift structs to synthesize SQLite table definitions.
- Reactive fetching uses @FetchAll, @FetchOne, and @Fetch property wrappers and works in SwiftUI views and in @Observable view models (and UIKit).
- CloudKit sync is managed by a SyncEngine actor that bridges local change tracking to CloudKit record zones and databases.

## Database setup and dependency injection
- Create a database factory (often named appDatabase) that opens the SQLite file, configures GRDB, and runs a DatabaseMigrator.
- Inject the DatabaseWriter through Dependencies so feature code can access it via @Dependency without hard-coding a concrete database type.
- App startup should set the default database using prepareDependencies. Tests and previews should override with a test database instance.

Example pattern (adapt to Maxwell DI style):
```swift
struct DatabaseKey: DependencyKey {
  static let liveValue: any DatabaseWriter = try! .appDatabase()
  static let testValue: any DatabaseWriter = .testDatabase
}

extension DependencyValues {
  var database: any DatabaseWriter {
    get { self[DatabaseKey.self] }
    set { self[DatabaseKey.self] = newValue }
  }
}

@main
struct MaxwellApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .prepareDependencies {
          $0.database = try! .appDatabase()
        }
    }
  }
}
```

## Data modeling with @Table
- Define each table as a Swift struct annotated with @Table. The macro derives table definitions from stored properties.
- Use Swift-native types for columns; SQLiteData maps them to SQLite column types and supports Codable and enums.
- Design with CloudKit in mind: avoid unsupported constraints and use UUID primary keys if CloudKit sync is planned.

Example:
```swift
@Table("bulbs")
struct Bulb: Codable, Identifiable {
  var id: UUID
  var name: String
  var isOn: Bool
}
```

## Fetching and observing
- Use @FetchAll for collections and @FetchOne for single records. @Fetch supports custom queries.
- These property wrappers publish updates when the database changes, which keeps SwiftUI views and view models reactive.
- Property wrappers are usable outside SwiftUI (e.g., in @Observable view models or UIKit controllers).

## Migrations
- Use GRDB's DatabaseMigrator to register schema changes and call migrate during database setup.
- Keep migrations small and explicit; add new migrations instead of editing old ones.

Example:
```swift
var migrator: DatabaseMigrator {
  var migrator = DatabaseMigrator()
  migrator.registerMigration("createBulbs") { db in
    try db.create(table: "bulbs") { t in
      t.column("id", .blob).primaryKey()
      t.column("name", .text).notNull()
      t.column("isOn", .boolean).notNull().defaults(to: false)
    }
  }
  return migrator
}
```

## CloudKit synchronization (design now, enable later)
- SQLiteData provides a SyncEngine actor that connects the local database to CloudKit record zones, tracks local changes, and pulls remote updates.
- Sync requires a CKContainer, a CKDatabase (private or shared), and a record zone configuration.
- Sync state is stored in the SQLite database, so the database must be the source of truth.
- In Maxwell today: keep schema compatible and isolate sync logic behind a repository so CloudKit can be enabled later.

## CloudKit schema constraints
- Primary keys must be UUIDs for CloudKit compatibility.
- Avoid SQLite-only features that CloudKit cannot represent (for example unique constraints and foreign keys).
- Keep relationships explicit in data models rather than relying on SQLite foreign keys.

## CloudKit sharing
- SQLiteData includes helpers for creating and accepting CKShare records so data can be shared via the shared database.
- Sharing integrates with UICloudSharingController for presenting the standard CloudKit sharing UI.
- Shared records live in the shared database, which is distinct from the private database.

## Conflict resolution
- Sync can encounter conflicts when local and remote edits collide.
- SQLiteData supports merge strategies; default behavior is last-write-wins but can be customized per type.
- Design repositories to surface conflict handling decisions rather than burying them in UI code.

## Assets
- CloudKit assets are stored as files and referenced by record fields.
- SQLiteData provides APIs for managing asset files alongside record data; store assets in stable local file URLs.

## Checklist when adding persistence in Maxwell
- Define @Table models for each feature type.
- Add/extend migrations in the database factory.
- Implement repository methods on top of DatabaseWriter and SQLiteData queries.
- Use @Fetch wrappers in SwiftUI or @Observable view models for reactive UI.
- Keep CloudKit constraints in mind (UUID keys, no unique constraints, no foreign keys).
