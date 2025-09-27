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

// MARK: - UITextView+TextEditorTests

@testable import HypeUI

final class UITextViewTextEditorTests: XCTestCase {
    func testKeyboardType() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.keyboardType(.numberPad)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.keyboardType, .numberPad)
    }

    func testAutocorrectionDisabled() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.autocorrectionDisabled()

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.autocorrectionType, .no)
    }

    func testAutocorrectionEnabled() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.autocorrectionDisabled(false)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.autocorrectionType, .yes)
    }

    func testTextContentType() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.textContentType(.name)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.textContentType, .name)
    }

    func testTextInputAutocapitalization() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.textInputAutocapitalization(.sentences)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.autocapitalizationType, .sentences)
    }

    func testTextEditorEditable() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.textEditorEditable(false)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertFalse(textView.isEditable)
    }

    func testTextEditorScrollable() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.textEditorScrollable(false)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertFalse(textView.isScrollEnabled)
    }

    func testScrollContentBackground() {
        // given
        let textView = UITextView()
        textView.backgroundColor = .systemBackground

        // when
        let modifiedTextView = textView.scrollContentBackground(true)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.backgroundColor, .clear)
    }

    func testSubmitLabel() {
        // given
        let textView = UITextView()

        // when
        let modifiedTextView = textView.submitLabel(.search)

        // then
        XCTAssertEqual(modifiedTextView, textView)
        XCTAssertEqual(textView.returnKeyType, .search)
    }
}
