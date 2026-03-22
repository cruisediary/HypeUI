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

// MARK: - SwitchTarget

private final class SwitchTarget: NSObject {
    private let action: (Bool) -> Void

    init(action: @escaping (Bool) -> Void) {
        self.action = action
    }

    @objc func valueChanged(_ sender: UISwitch) {
        action(sender.isOn)
    }
}

// MARK: - UISwitch (Toggle)

public extension UISwitch {

    /// Sets the on/off state of the switch.
    /// - Parameter isOn: A Boolean value that determines the on/off state of the switch.
    /// - Returns: Modified switch.
    func isOn(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }

    /// Sets the color used to tint the appearance of the switch when it is turned on.
    /// - Parameter color: The color used to tint the appearance of the switch when it is turned on.
    /// - Returns: Modified switch.
    func onTintColor(_ color: UIColor?) -> Self {
        onTintColor = color
        return self
    }

    /// Sets the color used to tint the color of the thumb.
    /// - Parameter color: The color used to tint the color of the thumb.
    /// - Returns: Modified switch.
    func thumbTintColor(_ color: UIColor?) -> Self {
        thumbTintColor = color
        return self
    }

    /// Sets the color used to tint the outline of the switch when it is turned off.
    /// - Parameter color: The color used to tint the outline of the switch when it is turned off.
    /// - Returns: Modified switch.
    func tintColor(_ color: UIColor?) -> Self {
        tintColor = color
        return self
    }

    /// Adds an action to perform when the switch value changes.
    /// - Parameter action: A closure that receives the new on/off state.
    /// - Returns: Modified switch.
    func onChange(_ action: @escaping (Bool) -> Void) -> Self {
        let target = SwitchTarget(action: action)
        addTarget(target, action: #selector(SwitchTarget.valueChanged(_:)), for: .valueChanged)
        retain(target)
        return self
    }
}
