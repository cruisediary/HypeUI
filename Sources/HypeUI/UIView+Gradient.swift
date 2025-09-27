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

// MARK: - UIView (Gradient)

public extension UIView {
    /// Direction for gradient
    enum GradientDirection {
        case horizontal
        case vertical
        case diagonal
        case custom(startPoint: CGPoint, endPoint: CGPoint)

        var points: (start: CGPoint, end: CGPoint) {
            switch self {
            case .horizontal:
                return (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
            case .diagonal:
                return (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1))
            case let .custom(start, end):
                return (start, end)
            }
        }
    }

    /// Applies a linear gradient background
    /// - Parameters:
    ///   - colors: Array of colors for the gradient
    ///   - direction: Direction of the gradient
    ///   - locations: Optional locations for color stops (0.0 to 1.0)
    /// - Returns: Modified view
    func gradient(colors: [UIColor],
                  direction: GradientDirection = .vertical,
                  locations: [NSNumber]? = nil) -> Self
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations

        let points = direction.points
        gradientLayer.startPoint = points.start
        gradientLayer.endPoint = points.end

        gradientLayer.name = "gradient_background"

        // Remove existing gradient layers
        removeGradient()

        // Insert at the bottom of the layer hierarchy
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Ensure frame updates when bounds change
        setNeedsLayout()

        return self
    }

    /// Applies a vertical gradient from top to bottom
    /// - Parameters:
    ///   - topColor: Top color
    ///   - bottomColor: Bottom color
    /// - Returns: Modified view
    func verticalGradient(from topColor: UIColor, to bottomColor: UIColor) -> Self {
        return gradient(colors: [topColor, bottomColor], direction: .vertical)
    }

    /// Applies a horizontal gradient from left to right
    /// - Parameters:
    ///   - leftColor: Left color
    ///   - rightColor: Right color
    /// - Returns: Modified view
    func horizontalGradient(from leftColor: UIColor, to rightColor: UIColor) -> Self {
        return gradient(colors: [leftColor, rightColor], direction: .horizontal)
    }

    /// Applies a radial gradient (using CAGradientLayer with type .radial)
    /// - Parameters:
    ///   - colors: Array of colors for the gradient
    ///   - center: Center point of the gradient (0.0 to 1.0 coordinates)
    ///   - radius: Radius of the gradient (0.0 to 1.0)
    /// - Returns: Modified view
    func radialGradient(colors: [UIColor],
                        center: CGPoint = CGPoint(x: 0.5, y: 0.5),
                        radius: CGFloat = 0.5) -> Self
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.type = .radial
        gradientLayer.startPoint = center
        gradientLayer.endPoint = CGPoint(x: center.x + radius, y: center.y + radius)
        gradientLayer.name = "gradient_background"

        // Remove existing gradient layers
        removeGradient()

        // Insert at the bottom of the layer hierarchy
        layer.insertSublayer(gradientLayer, at: 0)
        
        // Ensure frame updates when bounds change
        setNeedsLayout()

        return self
    }

    /// Removes gradient background
    /// - Returns: Modified view
    func removeGradient() -> Self {
        layer.sublayers?.removeAll { sublayer in
            sublayer.name == "gradient_background"
        }
        return self
    }

    /// Updates gradient frame when view bounds change
    /// Call this in layoutSubviews or similar methods
    func updateGradientFrame() {
        layer.sublayers?.forEach { sublayer in
            if sublayer.name == "gradient_background" {
                sublayer.frame = bounds
            }
        }
    }
}
