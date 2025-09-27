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

// MARK: - UITextField (SwiftUI Style)

public extension UITextField {
    /// Sets the keyboard type for the text field
    /// - Parameter type: The keyboard type to use
    /// - Returns: Modified text field
    func keyboardType(_ type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }

    /// Sets whether to disable autocorrection for the text field
    /// - Parameter disabled: Whether autocorrection is disabled
    /// - Returns: Modified text field
    func autocorrectionDisabled(_ disabled: Bool = true) -> Self {
        autocorrectionType = disabled ? .no : .yes
        return self
    }

    /// Sets the text field's text content type for autofill
    /// - Parameter type: The text content type
    /// - Returns: Modified text field
    func textContentType(_ type: UITextContentType?) -> Self {
        textContentType = type
        return self
    }

    /// Sets the text field style similar to SwiftUI's textFieldStyle
    /// - Parameter style: The border style to apply
    /// - Returns: Modified text field
    func textFieldStyle(_ style: UITextField.BorderStyle) -> Self {
        borderStyle = style
        return self
    }

    /// Sets the submit label for the return key
    /// - Parameter label: The return key type
    /// - Returns: Modified text field
    func submitLabel(_ label: UIReturnKeyType) -> Self {
        returnKeyType = label
        return self
    }

    /// Sets the text capitalization style
    /// - Parameter style: The capitalization style
    /// - Returns: Modified text field
    func textInputAutocapitalization(_ style: UITextAutocapitalizationType) -> Self {
        autocapitalizationType = style
        return self
    }

    /// Sets whether the text field is a secure entry (password field)
    /// - Parameter isSecure: Whether to obscure the text
    /// - Returns: Modified text field
    func secureField(_ isSecure: Bool = true) -> Self {
        isSecureTextEntry = isSecure
        return self
    }
}
