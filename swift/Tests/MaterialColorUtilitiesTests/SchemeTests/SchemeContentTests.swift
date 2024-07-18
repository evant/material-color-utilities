// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import XCTest

@testable import MaterialColorUtilities

final class SchemeContentTests: XCTestCase {
  func testLightThemeMinContrastObjectionabeTertiaryContainerLightens() {
    let scheme = SchemeContent(
      sourceColorHct: Hct.fromInt(0xff85_0096),
      isDark: false,
      contrastLevel: -1
    )

    let color = MaterialDynamicColors.tertiaryContainer.getArgb(scheme)

    XCTAssertEqual(color, 0xffff_ccd7)
  }

  func testLightThemeStandardContrastObjectionabeTertiaryContainerLightens() {
    let scheme = SchemeContent(
      sourceColorHct: Hct.fromInt(0xff85_0096),
      isDark: false,
      contrastLevel: 0
    )

    XCTAssertEqual(MaterialDynamicColors.tertiaryContainer.getArgb(scheme), 0xff98_0249)
  }

  func testLightThemeMaxContrastObjectionabeTertiaryContainerDarkens() {
    let scheme = SchemeContent(
      sourceColorHct: Hct.fromInt(0xff85_0096),
      isDark: false,
      contrastLevel: 1
    )

    XCTAssertEqual(MaterialDynamicColors.tertiaryContainer.getArgb(scheme), 0xff93_0046)
  }

  func testSchemeContentProvider_returnsIdeniticalSchemeWithSameSourceColor() {
    let sourceColorHct = Hct(0xfffa_2bec)
    let isDark = false
    let contrastLevel = 0.0

    let scheme = SchemeContent(
      sourceColorHct: sourceColorHct, isDark: isDark, contrastLevel: contrastLevel)
    let provider = SchemeContentProvider(sourceColorHct: sourceColorHct)
    let schemeByProvider = provider.scheme(isDark: isDark, contrastLevel: contrastLevel)

    XCTAssertEqual(scheme, schemeByProvider)
  }

  func testSchemeContentProvider_reusesTonalPalettes() {
    let provider = SchemeContentProvider(sourceColorHct: Hct(0xfffa_2bec))

    let scheme1 = provider.scheme(isDark: true, contrastLevel: 0.0)
    let scheme2 = provider.scheme(isDark: false, contrastLevel: 1.0)

    // Check if the same tonal palettes are being reused
    XCTAssertIdentical(scheme1.primaryPalette, scheme2.primaryPalette)
    XCTAssertIdentical(scheme1.secondaryPalette, scheme2.secondaryPalette)
    XCTAssertIdentical(scheme1.tertiaryPalette, scheme2.tertiaryPalette)
    XCTAssertIdentical(scheme1.neutralPalette, scheme2.neutralPalette)
    XCTAssertIdentical(scheme1.neutralVariantPalette, scheme2.neutralVariantPalette)
  }
}
