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

// MARK: - UIView (Layout)

public extension UIView {
    /// Centers the view in its superview
    /// - Parameters:
    ///   - horizontally: Whether to center horizontally
    ///   - vertically: Whether to center vertically
    /// - Returns: Modified view
    @discardableResult
    func center(horizontally: Bool = true, vertically: Bool = true) -> Self {
        guard let superview = superview else { return self }

        translatesAutoresizingMaskIntoConstraints = false

        if horizontally {
            centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        }

        if vertically {
            centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }

        return self
    }

    /// Fills the superview with optional insets
    /// - Parameters:
    ///   - insets: Edge insets from superview
    ///   - respectSafeArea: Whether to respect safe area
    /// - Returns: Modified view
    @discardableResult
    func fillSuperview(insets: UIEdgeInsets = .zero, respectSafeArea: Bool = false) -> Self {
        guard let superview = superview else { return self }

        translatesAutoresizingMaskIntoConstraints = false

        if respectSafeArea {
            let guide = superview.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.top),
                leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom),
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            ])
        }

        return self
    }

    /// Sets exact size constraints
    /// - Parameters:
    ///   - width: Width constraint (nil to ignore)
    ///   - height: Height constraint (nil to ignore)
    /// - Returns: Modified view
    @discardableResult
    func exactSize(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        return self
    }

    /// Sets square size constraint
    /// - Parameter size: Size for both width and height
    /// - Returns: Modified view
    @discardableResult
    func exactSize(_ size: CGFloat) -> Self {
        return exactSize(width: size, height: size)
    }

    /// Sets minimum size constraints
    /// - Parameters:
    ///   - width: Minimum width (nil to ignore)
    ///   - height: Minimum height (nil to ignore)
    /// - Returns: Modified view
    @discardableResult
    func minSize(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false

        if let width = width {
            widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        }

        return self
    }

    /// Sets maximum size constraints
    /// - Parameters:
    ///   - width: Maximum width (nil to ignore)
    ///   - height: Maximum height (nil to ignore)
    /// - Returns: Modified view
    @discardableResult
    func maxSize(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false

        if let width = width {
            widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
        }

        return self
    }

    /// Pins view to superview edges
    /// - Parameters:
    ///   - edges: Edges to pin to
    ///   - constant: Constant offset
    /// - Returns: Modified view
    @discardableResult
    func pin(to edges: UIRectEdge, constant: CGFloat = 0) -> Self {
        guard let superview = superview else { return self }

        translatesAutoresizingMaskIntoConstraints = false

        if edges.contains(.top) {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        }

        if edges.contains(.bottom) {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
        }

        if edges.contains(.left) {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        }

        if edges.contains(.right) {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        }

        return self
    }

    /// Aligns view to another view
    /// - Parameters:
    ///   - view: View to align to
    ///   - attribute: Layout attribute to align
    ///   - constant: Constant offset
    /// - Returns: Modified view
    @discardableResult
    func align(to view: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat = 0) -> Self {
        guard let superview = superview else { return self }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal,
                           toItem: view, attribute: attribute, multiplier: 1.0, constant: constant).isActive = true

        return self
    }

    /// Sets aspect ratio constraint
    /// - Parameter ratio: Width to height ratio
    /// - Returns: Modified view
    @discardableResult
    func aspectRatio(_ ratio: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
        return self
    }

    /// Adds insets to all sides when filling superview
    /// - Parameter inset: Inset value for all sides
    /// - Returns: Modified view
    @discardableResult
    func inset(_ inset: CGFloat) -> Self {
        return fillSuperview(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    /// Adds insets with individual values when filling superview
    /// - Parameters:
    ///   - top: Top inset
    ///   - left: Left inset
    ///   - bottom: Bottom inset
    ///   - right: Right inset
    /// - Returns: Modified view
    @discardableResult
    func inset(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self {
        return fillSuperview(insets: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    /// Removes all constraints from the view without removing it from superview
    /// - Returns: Modified view
    @discardableResult
    func removeAllConstraints() -> Self {
        // Remove constraints where this view is the first item
        constraints.forEach { $0.isActive = false }
        
        // Remove constraints from superview where this view is involved
        superview?.constraints.forEach { constraint in
            if constraint.firstItem === self || constraint.secondItem === self {
                constraint.isActive = false
            }
        }
        
        // Reset to use autoresizing masks
        translatesAutoresizingMaskIntoConstraints = true
        
        return self
    }
    
    /// Removes the view from superview and resets constraint settings
    /// This effectively removes all constraints involving this view
    /// - Returns: Modified view
    @discardableResult
    func removeFromSuperviewAndResetConstraints() -> Self {
        removeFromSuperview()
        translatesAutoresizingMaskIntoConstraints = true
        return self
    }
    
    /// Updates all HypeUI layer frames (borders, gradients) when bounds change.
    /// Call this method in your view's layoutSubviews to ensure proper layer sizing.
    /// - Returns: Modified view
    @discardableResult
    func updateHypeUILayers() -> Self {
        updateBorderLayerFrames()
        updateGradientFrame()
        return self
    }
}
