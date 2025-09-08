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

private var debouncerKey: UInt8 = 0

// MARK: - UIControl (DebouncedAction)

public extension UIControl {
    
    /// Adds debounced action to control events with specified delay
    /// - Parameters:
    ///   - delay: Delay interval in seconds before executing the action
    ///   - events: Control events that trigger the action
    ///   - action: Action closure to execute
    /// - Returns: Modified control
    func debouncedAction(delay: TimeInterval = 0.3, 
                        for events: UIControl.Event = .touchUpInside,
                        action: @escaping () -> Void) -> Self {
        let debouncer = ActionDebouncer(delay: delay, action: action)
        objc_setAssociatedObject(self, &debouncerKey, debouncer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        addTarget(debouncer, action: #selector(ActionDebouncer.execute), for: events)
        return self
    }
}

// MARK: - ActionDebouncer

private class ActionDebouncer: NSObject {
    private let delay: TimeInterval
    private let action: () -> Void
    private var workItem: DispatchWorkItem?
    
    init(delay: TimeInterval, action: @escaping () -> Void) {
        self.delay = delay
        self.action = action
        super.init()
    }
    
    @objc func execute() {
        workItem?.cancel()
        workItem = DispatchWorkItem { [weak self] in
            self?.action()
        }
        
        if let workItem = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }
}