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

// MARK: - UIView (Shadow)

public extension UIView {
    /// Applies a shadow to the view with specified properties
    /// - Parameters:
    ///   - color: Shadow color
    ///   - radius: Shadow blur radius
    ///   - offset: Shadow offset from the view
    ///   - opacity: Shadow opacity (0.0 to 1.0)
    /// - Returns: Modified view
    func shadow(color: UIColor = .black,
                radius: CGFloat = 4.0,
                offset: CGSize = CGSize(width: 0, height: 2),
                opacity: Float = 0.2) -> Self
    {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
        return self
    }

    /// Applies a simple drop shadow with default styling
    /// - Returns: Modified view
    func dropShadow() -> Self {
        return shadow()
    }

    /// Removes any shadow from the view
    /// - Returns: Modified view
    func removeShadow() -> Self {
        layer.shadowOpacity = 0
        return self
    }
}
