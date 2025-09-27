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

// MARK: - UIView (Animation)

public extension UIView {
    /// Fades the view in with animation
    /// - Parameters:
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func fadeIn(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) -> Self {
        alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }) { _ in
            completion?()
        }
        return self
    }

    /// Fades the view out with animation
    /// - Parameters:
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func fadeOut(duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) -> Self {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) { _ in
            completion?()
        }
        return self
    }

    /// Slides the view in from a specified direction
    /// - Parameters:
    ///   - direction: Direction to slide from
    ///   - distance: Distance to slide (default: view's width/height)
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func slideIn(from direction: SlideDirection,
                 distance: CGFloat? = nil,
                 duration: TimeInterval = 0.3,
                 completion: (() -> Void)? = nil) -> Self
    {
        let slideDistance = distance ?? (direction.isHorizontal ? bounds.width : bounds.height)
        let originalTransform = transform

        switch direction {
        case .left:
            transform = transform.translatedBy(x: -slideDistance, y: 0)
        case .right:
            transform = transform.translatedBy(x: slideDistance, y: 0)
        case .top:
            transform = transform.translatedBy(x: 0, y: -slideDistance)
        case .bottom:
            transform = transform.translatedBy(x: 0, y: slideDistance)
        }

        UIView.animate(withDuration: duration, animations: {
            self.transform = originalTransform
        }) { _ in
            completion?()
        }
        return self
    }

    /// Scales the view with animation
    /// - Parameters:
    ///   - scale: Scale factor
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func scale(to scale: CGFloat,
               duration: TimeInterval = 0.3,
               completion: (() -> Void)? = nil) -> Self
    {
        UIView.animate(withDuration: duration, animations: {
            self.transform = self.transform.scaledBy(x: scale, y: scale)
        }) { _ in
            completion?()
        }
        return self
    }

    /// Pops the view with a bounce effect
    /// - Parameters:
    ///   - scale: Maximum scale during bounce
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func pop(scale: CGFloat = 1.1,
             duration: TimeInterval = 0.2,
             completion: (() -> Void)? = nil) -> Self
    {
        let originalTransform = transform

        UIView.animate(withDuration: duration / 2,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                           self.transform = originalTransform.scaledBy(x: scale, y: scale)
                       }) { _ in
            UIView.animate(withDuration: duration / 2,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut,
                           animations: {
                               self.transform = originalTransform
                           }) { _ in
                completion?()
            }
        }
        return self
    }

    /// Shakes the view horizontally
    /// - Parameters:
    ///   - intensity: Shake intensity (distance)
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func shake(intensity: CGFloat = 10,
               duration: TimeInterval = 0.6,
               completion: (() -> Void)? = nil) -> Self
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = duration
        animation.values = [0, -intensity, intensity, -intensity, intensity, -intensity / 2, intensity / 2, 0]
        animation.autoreverses = false

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        layer.add(animation, forKey: "shake")
        CATransaction.commit()

        return self
    }

    /// Rotates the view with animation
    /// - Parameters:
    ///   - angle: Rotation angle in radians
    ///   - duration: Animation duration
    ///   - completion: Completion block
    /// - Returns: Modified view
    @discardableResult
    func rotate(by angle: CGFloat,
                duration: TimeInterval = 0.3,
                completion: (() -> Void)? = nil) -> Self
    {
        UIView.animate(withDuration: duration, animations: {
            self.transform = self.transform.rotated(by: angle)
        }) { _ in
            completion?()
        }
        return self
    }

    /// Pulse animation (scale up and down)
    /// - Parameters:
    ///   - scale: Maximum scale during pulse
    ///   - duration: Animation duration
    ///   - repeatCount: Number of pulses (0 for infinite)
    /// - Returns: Modified view
    @discardableResult
    func pulse(scale: CGFloat = 1.05,
               duration: TimeInterval = 1.0,
               repeatCount: Float = 0) -> Self
    {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = scale
        animation.duration = duration / 2
        animation.autoreverses = true
        animation.repeatCount = repeatCount

        layer.add(animation, forKey: "pulse")
        return self
    }

    /// Stops pulse animation
    /// - Returns: Modified view
    @discardableResult
    func stopPulse() -> Self {
        layer.removeAnimation(forKey: "pulse")
        return self
    }
}

// MARK: - SlideDirection

public extension UIView {
    enum SlideDirection {
        case left, right, top, bottom

        var isHorizontal: Bool {
            return self == .left || self == .right
        }
    }
}
