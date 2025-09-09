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

// MARK: - UITextView (SwiftUI Style)

public extension UITextView {
    
    /// Sets the keyboard type for the text view
    /// - Parameter type: The keyboard type to use
    /// - Returns: Modified text view
    func keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }
    
    /// Sets whether to disable autocorrection for the text view
    /// - Parameter disabled: Whether autocorrection is disabled
    /// - Returns: Modified text view
    func autocorrectionDisabled(_ disabled: Bool = true) -> Self {
        self.autocorrectionType = disabled ? .no : .yes
        return self
    }
    
    /// Sets the text view's text content type for autofill
    /// - Parameter type: The text content type
    /// - Returns: Modified text view
    func textContentType(_ type: UITextContentType?) -> Self {
        self.textContentType = type
        return self
    }
    
    /// Sets the text capitalization style
    /// - Parameter style: The capitalization style
    /// - Returns: Modified text view
    func textInputAutocapitalization(_ style: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = style
        return self
    }
    
    /// Sets whether the text view is editable
    /// - Parameter editable: Whether the text view is editable
    /// - Returns: Modified text view
    func textEditorEditable(_ editable: Bool) -> Self {
        self.isEditable = editable
        return self
    }
    
    /// Sets whether the text view is scrollable
    /// - Parameter scrollable: Whether the text view can scroll
    /// - Returns: Modified text view
    func textEditorScrollable(_ scrollable: Bool) -> Self {
        self.isScrollEnabled = scrollable
        return self
    }
    
    /// Hides the scroll content background (similar to SwiftUI's scrollContentBackground)
    /// - Parameter hidden: Whether to hide the background
    /// - Returns: Modified text view
    func scrollContentBackground(_ hidden: Bool) -> Self {
        if hidden {
            self.backgroundColor = .clear
        }
        return self
    }
    
    /// Sets the submit label for the return key
    /// - Parameter label: The return key type
    /// - Returns: Modified text view
    func submitLabel(_ label: UIReturnKeyType) -> Self {
        self.returnKeyType = label
        return self
    }
}