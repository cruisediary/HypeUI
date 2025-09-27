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

// MARK: - UITextField+TextInputTests

@testable import HypeUI

final class UITextFieldTextInputTests: XCTestCase {
    func testKeyboardType() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.keyboardType(.emailAddress)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.keyboardType, .emailAddress)
    }

    func testAutocorrectionDisabled() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.autocorrectionDisabled()

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.autocorrectionType, .no)
    }

    func testAutocorrectionEnabled() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.autocorrectionDisabled(false)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.autocorrectionType, .yes)
    }

    func testTextContentType() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.textContentType(.emailAddress)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.textContentType, .emailAddress)
    }

    func testTextFieldStyle() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.textFieldStyle(.roundedRect)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.borderStyle, .roundedRect)
    }

    func testSubmitLabel() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.submitLabel(.done)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.returnKeyType, .done)
    }

    func testTextInputAutocapitalization() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.textInputAutocapitalization(.words)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertEqual(textField.autocapitalizationType, .words)
    }

    func testSecureField() {
        // given
        let textField = UITextField()

        // when
        let modifiedTextField = textField.secureField()

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertTrue(textField.isSecureTextEntry)
    }

    func testSecureFieldDisabled() {
        // given
        let textField = UITextField()
        textField.isSecureTextEntry = true

        // when
        let modifiedTextField = textField.secureField(false)

        // then
        XCTAssertEqual(modifiedTextField, textField)
        XCTAssertFalse(textField.isSecureTextEntry)
    }
}
