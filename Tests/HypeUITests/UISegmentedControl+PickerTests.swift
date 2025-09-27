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

// MARK: - UISegmentedControl+PickerTests

@testable import HypeUI

final class UISegmentedControlPickerTests: XCTestCase {
    func testSelection() {
        // given
        let segmentedControl = UISegmentedControl(items: ["First", "Second", "Third"])

        // when
        let modifiedControl = segmentedControl.selection(1)

        // then
        XCTAssertEqual(modifiedControl, segmentedControl)
        XCTAssertEqual(segmentedControl.selectedSegmentIndex, 1)
    }

    func testPickerEnabled() {
        // given
        let segmentedControl = UISegmentedControl(items: ["Option 1", "Option 2"])

        // when
        let modifiedControl = segmentedControl.pickerEnabled(false)

        // then
        XCTAssertEqual(modifiedControl, segmentedControl)
        XCTAssertFalse(segmentedControl.isEnabled)
    }

    func testSelectedSegmentTintColor() {
        // given
        let segmentedControl = UISegmentedControl(items: ["A", "B"])
        let testColor = UIColor.red

        // when
        let modifiedControl = segmentedControl.selectedSegmentTintColor(testColor)

        // then
        XCTAssertEqual(modifiedControl, segmentedControl)
        if #available(iOS 13.0, *) {
            XCTAssertEqual(segmentedControl.selectedSegmentTintColor, testColor)
        } else {
            XCTAssertEqual(segmentedControl.tintColor, testColor)
        }
    }

    func testSegmentedControlBackgroundColor() {
        // given
        let segmentedControl = UISegmentedControl(items: ["X", "Y"])
        let testColor = UIColor.blue

        // when
        let modifiedControl = segmentedControl.segmentedControlBackgroundColor(testColor)

        // then
        XCTAssertEqual(modifiedControl, segmentedControl)
        if #available(iOS 13.0, *) {
            XCTAssertEqual(segmentedControl.backgroundColor, testColor)
        }
    }

    func testMomentary() {
        // given
        let segmentedControl = UISegmentedControl(items: ["On", "Off"])

        // when
        let modifiedControl = segmentedControl.momentary(true)

        // then
        XCTAssertEqual(modifiedControl, segmentedControl)
        XCTAssertTrue(segmentedControl.isMomentary)
    }

    func testOnSelectionChange() {
        // given
        let segmentedControl = UISegmentedControl(items: ["First", "Second"])
        var selectedIndex: Int?
        let expectation = self.expectation(description: "Selection change should be called")

        // when
        let modifiedControl = segmentedControl.onSelectionChange { index in
            selectedIndex = index
            expectation.fulfill()
        }

        modifiedControl.selectedSegmentIndex = 1

        if let target = modifiedControl.allTargets.first as? NSObject,
           let actions = modifiedControl.actions(forTarget: target, forControlEvent: .valueChanged),
           let actionName = actions.first
        {
            let selector = Selector(actionName)
            _ = target.perform(selector, with: modifiedControl)
        }

        // then
        XCTAssertEqual(modifiedControl, segmentedControl)
        waitForExpectations(timeout: 0.5)
        XCTAssertEqual(selectedIndex, 1)
    }
}
