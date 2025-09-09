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

// MARK: - UISegmentedControl (Picker)

public extension UISegmentedControl {
    
    /// Sets the selected segment index (SwiftUI-style selection)
    /// - Parameter index: The index of the segment to select
    /// - Returns: Modified segmented control
    func selection(_ index: Int) -> Self {
        self.selectedSegmentIndex = index
        return self
    }
    
    /// Sets whether the segmented control is enabled
    /// - Parameter enabled: Whether the control is enabled
    /// - Returns: Modified segmented control
    func pickerEnabled(_ enabled: Bool) -> Self {
        self.isEnabled = enabled
        return self
    }
    
    /// Sets the background color for the selected segment
    /// - Parameter color: The background color for selected state
    /// - Returns: Modified segmented control
    func selectedSegmentTintColor(_ color: UIColor?) -> Self {
        if #available(iOS 13.0, *) {
            self.selectedSegmentTintColor = color
        } else {
            self.tintColor = color
        }
        return self
    }
    
    /// Sets the background color of the segmented control
    /// - Parameter color: The background color
    /// - Returns: Modified segmented control
    func segmentedControlBackgroundColor(_ color: UIColor?) -> Self {
        if #available(iOS 13.0, *) {
            self.backgroundColor = color
        }
        return self
    }
    
    /// Sets whether the control momentarily highlights segments when touched
    /// - Parameter momentary: Whether to use momentary selection
    /// - Returns: Modified segmented control
    func momentary(_ momentary: Bool) -> Self {
        self.isMomentary = momentary
        return self
    }
    
    /// Adds an action for value changed events (similar to SwiftUI Picker selection)
    /// - Parameter action: Action to execute when selection changes
    /// - Returns: Modified segmented control
    func onSelectionChange(_ action: @escaping (Int) -> Void) -> Self {
        let target = SegmentedControlTarget(action: action)
        addTarget(target, action: #selector(SegmentedControlTarget.valueChanged), for: .valueChanged)
        retain(target)
        return self
    }
}

// MARK: - SegmentedControlTarget

private class SegmentedControlTarget: NSObject {
    private let action: (Int) -> Void
    
    init(action: @escaping (Int) -> Void) {
        self.action = action
        super.init()
    }
    
    @objc func valueChanged(_ sender: UISegmentedControl) {
        action(sender.selectedSegmentIndex)
    }
}