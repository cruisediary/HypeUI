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

// MARK: - UIControl+DebouncedActionTests

@testable import HypeUI

final class UIControlDebouncedActionTests: XCTestCase {
    func testDebouncedActionExecutesAfterDelay() {
        // given
        let button = UIButton()
        var actionExecuted = false
        let expectation = self.expectation(description: "Action should execute after delay")

        // when
        button.debouncedAction(delay: 0.05) {
            actionExecuted = true
            expectation.fulfill()
        }

        if let target = button.allTargets.first as? NSObject,
           let actions = button.actions(forTarget: target, forControlEvent: .touchUpInside),
           let actionName = actions.first
        {
            let selector = Selector(actionName)
            _ = target.perform(selector, with: button)
        }

        // then
        XCTAssertFalse(actionExecuted)
        waitForExpectations(timeout: 0.5)
        XCTAssertTrue(actionExecuted)
    }

    func testDebouncedActionCancelsEarlierCalls() {
        // given
        let button = UIButton()
        var executionCount = 0
        let expectation = self.expectation(description: "Action should execute only once")

        // when
        button.debouncedAction(delay: 0.05) { // 더 짧은 딜레이로 테스트 속도 향상
            executionCount += 1
            expectation.fulfill()
        }

        if let target = button.allTargets.first as? NSObject,
           let actions = button.actions(forTarget: target, forControlEvent: .touchUpInside),
           let actionName = actions.first
        {
            let selector = Selector(actionName)
            _ = target.perform(selector, with: button)
            _ = target.perform(selector, with: button)
            _ = target.perform(selector, with: button)
        }

        // then
        waitForExpectations(timeout: 0.5)
        XCTAssertEqual(executionCount, 1)
    }

    func testDebouncedActionWithCustomEvents() {
        // given
        let textField = UITextField()
        var actionExecuted = false
        let expectation = self.expectation(description: "Action should execute for custom event")

        // when
        textField.debouncedAction(delay: 0.05, for: .editingChanged) { // 더 짧은 딜레이로 테스트 속도 향상
            actionExecuted = true
            expectation.fulfill()
        }

        if let target = textField.allTargets.first as? NSObject,
           let actions = textField.actions(forTarget: target, forControlEvent: .editingChanged),
           let actionName = actions.first
        {
            let selector = Selector(actionName)
            _ = target.perform(selector, with: textField)
        }

        // then
        waitForExpectations(timeout: 0.5)
        XCTAssertTrue(actionExecuted)
    }
}
