# Light Bulb Types & Properties (Research Draft)

This document provides a comprehensive, app-friendly catalog of light bulb properties including technology types, fittings (bases), shapes, and color temperature guidance. It is designed to support a light bulb management app with structured data for filtering, comparison, and inventory tracking.

> **Note on sources:** External web access is currently blocked in this environment (HTTP 403). The entries below reflect standard industry nomenclature that should be verified against public references once access is available. A list of recommended sources is included at the end.

## Core properties to model
- **Technology type:** incandescent, halogen, CFL, linear fluorescent, LED, HID (metal halide, high-pressure sodium, low-pressure sodium, mercury vapor), induction, OLED.
- **Fitting/base:** mechanical/electrical interface (e.g., E26, B22d, GU10, G9).
- **Shape code:** bulb envelope form factor (e.g., A19, BR30, PAR38, T8).
- **Color temperature (CCT):** correlated color temperature in Kelvin (K), with a perceptual category (warm/neutral/cool) and approximate UI hex swatch.
- **Beam & optics:** beam angle (spot, flood), reflector type (PAR, BR, MR), diffusion (frosted, clear).
- **Electrical:** wattage, voltage, dimmable/non-dimmable, driver type (for LED).
- **Performance:** lumens, efficacy (lm/W), CRI/Ra, lifetime, warm-up time.
- **Safety & compliance:** certifications (UL/ETL/CE), enclosure ratings, mercury content (CFL/fluorescent).

## Technology types
| Technology | Description | Typical uses | Notes |
| --- | --- | --- | --- |
| Incandescent | Tungsten filament in a vacuum or inert gas. | General household, decorative. | Warm CCT, low efficacy, short life. |
| Halogen | Improved incandescent with halogen gas cycle. | Accent, spotlighting. | Higher efficacy than incandescent, hot surface. |
| CFL | Compact fluorescent lamp with ballast. | General household/office. | Contains mercury, warm-up time. |
| Linear fluorescent | Long tube with ballast (T5/T8/T12). | Offices, industrial. | Common G5/G13 bases. |
| LED | Light-emitting diodes with driver. | Most modern use cases. | High efficacy, many shapes/CCTs. |
| HID (Metal Halide) | Arc lamp with metal halide salts. | Outdoor, high-bay. | High output, warm-up time. |
| HID (High-Pressure Sodium) | Arc lamp, sodium vapor. | Street lighting. | Orange hue, high efficacy. |
| HID (Low-Pressure Sodium) | Monochromatic sodium. | Specialized roadway. | Extremely narrow color spectrum. |
| HID (Mercury Vapor) | Arc lamp with mercury. | Legacy outdoor lighting. | Poor color rendering, long life. |
| Induction | Electrodeless fluorescent. | Long-life commercial. | Very long life, bulky. |
| OLED | Organic LED panels. | Decorative, niche. | Thin panels, low brightness. |

## Fittings (bases)
The app should treat fittings as a **family** (e.g., Edison screw) plus **size**/variant (e.g., E26 vs E27). This table lists common families with size variants to support comprehensive data entry.

| Fitting family | Common sizes/variants | Typical use | Notes | Image |
| --- | --- | --- | --- | --- |
| Edison screw (E) | E10, E11, E12, E14, E17, E26, E27, E39, E40 | General household & commercial | Threaded screw base; E26/E27 are the dominant household sizes. | ![Edison screw](assets/bulb-fittings/edison-screw.svg) |
| Bayonet (B/BA/BAY) | B15d, B22d, BA15d, BAY15d, BA9s | UK/EU household, automotive | Push-and-twist with side pins. | ![Bayonet](assets/bulb-fittings/bayonet.svg) |
| Bi-pin (G) | G4, G5, G6.35, G8, G9, G13, G23, G24, 2G7, 2G11 | MR/spotlights, CFL, tubes | Straight pins; pin spacing defines size. | ![Bi-pin](assets/bulb-fittings/bi-pin.svg) |
| Twist-lock (GU/GZ) | GU10, GU5.3, GU4, GU24, GZ10 | Recessed/spot fixtures | Short pins with twist-lock action. | ![GU10](assets/bulb-fittings/gu10.svg) |
| Loop pin (G9) | G9 | Mini halogen/LED capsules | Two looped wire contacts. | ![G9 loop](assets/bulb-fittings/g9-loop.svg) |
| Tube end (G13/G5) | G13 (T8/T12), G5 (T5) | Linear fluorescent/LED tubes | Widely used for tubes; rotation locks. | ![G13 tube](assets/bulb-fittings/g13-tube.svg) |
| Linear double-ended (R7s/RX7s) | R7s, RX7s | Linear halogen/LED replacements | Double-ended, linear lamps. | ![R7s](assets/bulb-fittings/r7s-linear.svg) |
| Disc base (GX53/GX70) | GX53, GX70 | Low-profile puck lamps | Flat disc with two recessed contacts. | ![GX53](assets/bulb-fittings/gx53.svg) |
| Wedge (T) | T10, T20 | Automotive & specialty | Push-in wedge contact. | ![Wedge](assets/bulb-fittings/wedge.svg) |

## Shape codes (bulb envelopes)
Shape codes help match physical fit and light distribution. Common entries the app should support:

| Shape code | Description | Typical use |
| --- | --- | --- |
| A15/A19/A21/A23 | Classic pear shape (A-series) | Household lamps |
| B10/B11 | Candle/torpedo | Chandeliers, decorative |
| C7/C9/C35 | Cone/candle | Decorative, night lights |
| G16.5/G25/G30/G40 | Globe | Vanity, decorative |
| ST19/ST64 | “Edison” vintage style | Decorative/statement |
| T5/T8/T12 | Tubular fluorescent/LED | Office/industrial |
| PAR16/PAR20/PAR30/PAR38 | Parabolic aluminized reflector | Spot/flood, recessed |
| BR20/BR30/BR40 | Bulged reflector | Recessed flood |
| MR11/MR16 | Multifaceted reflector | Track/spot lighting |
| R20/R30/R40 | Reflector (rounded) | Flood lighting |
| AR111 | Aluminum reflector | Accent lighting |
| S14/S11 | Sign/string lights | Marquee/string |
| BT15/BT28 | Bulged tube | HID/industrial |
| ED17/ED18 | Elliptical (HID) | Street/high-bay |

## Color temperature (CCT) with UI swatches
Hex values are approximate, computed from a blackbody approximation to represent typical perceived warmth.

| CCT (K) | Description | Approx. hex |
| --- | --- | --- |
| 1800K | Candlelight / ultra warm | `#FF7E00` |
| 2200K | Very warm | `#FF9227` |
| 2400K | Warm | `#FF9B3D` |
| 2700K | Soft warm (incandescent) | `#FFA757` |
| 3000K | Warm white | `#FFB16E` |
| 3500K | Neutral warm | `#FFC18D` |
| 4000K | Neutral white | `#FFCEA6` |
| 4500K | Cool white | `#FFDABB` |
| 5000K | Daylight white | `#FFE4CE` |
| 5500K | Daylight | `#FFEDDE` |
| 6500K | Cool daylight | `#FFFEFA` |
| 7500K | Overcast sky | `#E6EBFF` |

## Suggested data model fields
- **BulbType**: `id`, `name`, `technology`, `shapeCode`, `fittingFamily`, `fittingSize`, `cctKelvin`, `cctLabel`, `cctHex`, `lumens`, `wattage`, `voltage`, `beamAngle`, `dimmable`, `notes`.
- **FittingFamily**: `id`, `name`, `description`, `imageAsset`, `commonSizes`.
- **ShapeCode**: `code`, `description`, `commonUses`.

## Recommended sources to validate/extend
- IES (Illuminating Engineering Society) lighting fundamentals
- ANSI/IEC bulb shape and base standards
- Manufacturer reference guides (Philips, GE, LEDVANCE, Osram)
- Wikipedia: Lamp fitting, Edison screw, Bayonet mount, Bi-pin lamp base
- U.S. DOE lighting guides for technology comparisons
