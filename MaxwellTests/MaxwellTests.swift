//
//  MaxwellTests.swift
//  MaxwellTests
//
//  Created by Jacob Bartlett on 20/01/2026.
//

import Testing
@testable import Maxwell

struct MaxwellTests {

    @Test func greetingWithName() {
        #expect(GreetingBuilder.greeting(name: "Max") == "Hello, Max!")
    }

    @Test func greetingWithWhitespaceReturnsDefault() {
        #expect(GreetingBuilder.greeting(name: "   \n\t") == "Hello!")
    }

}
