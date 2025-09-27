//
//  Copyright 2022 Hyperconnect Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import XCTest

// MARK: - UIView+ShadowTests

@testable import HypeUI

final class UIViewShadowTests: XCTestCase {
    func testShadowWithDefaultValues() {
        // given
        let view = UIView()

        // when
        let modifiedView = view.shadow()

        // then
        XCTAssertEqual(modifiedView, view)
        XCTAssertEqual(view.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(view.layer.shadowRadius, 4.0)
        XCTAssertEqual(view.layer.shadowOffset, CGSize(width: 0, height: 2))
        XCTAssertEqual(view.layer.shadowOpacity, 0.2)
        XCTAssertFalse(view.layer.masksToBounds)
    }

    func testShadowWithCustomValues() {
        // given
        let view = UIView()
        let customColor = UIColor.red
        let customRadius: CGFloat = 8.0
        let customOffset = CGSize(width: 3, height: 5)
        let customOpacity: Float = 0.5

        // when
        let modifiedView = view.shadow(
            color: customColor,
            radius: customRadius,
            offset: customOffset,
            opacity: customOpacity
        )

        // then
        XCTAssertEqual(modifiedView, view)
        XCTAssertEqual(view.layer.shadowColor, customColor.cgColor)
        XCTAssertEqual(view.layer.shadowRadius, customRadius)
        XCTAssertEqual(view.layer.shadowOffset, customOffset)
        XCTAssertEqual(view.layer.shadowOpacity, customOpacity)
        XCTAssertFalse(view.layer.masksToBounds)
    }

    func testDropShadow() {
        // given
        let view = UIView()

        // when
        let modifiedView = view.dropShadow()

        // then
        XCTAssertEqual(modifiedView, view)
        XCTAssertEqual(view.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(view.layer.shadowRadius, 4.0)
        XCTAssertEqual(view.layer.shadowOffset, CGSize(width: 0, height: 2))
        XCTAssertEqual(view.layer.shadowOpacity, 0.2)
        XCTAssertFalse(view.layer.masksToBounds)
    }

    func testRemoveShadow() {
        // given
        let view = UIView()
        view.shadow(opacity: 0.5)

        // when
        let modifiedView = view.removeShadow()

        // then
        XCTAssertEqual(modifiedView, view)
        XCTAssertEqual(view.layer.shadowOpacity, 0.0)
    }
}
