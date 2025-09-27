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

// MARK: - UIView (Border)

public extension UIView {
    /// Applies border with specified color, width, and corner radius
    /// - Parameters:
    ///   - color: Border color
    ///   - width: Border width
    ///   - cornerRadius: Corner radius for the border
    /// - Returns: Modified view
    func borderedWithRadius(color: UIColor, width: CGFloat = 1.0, cornerRadius: CGFloat = 0) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        return self
    }

    /// Removes border from the view
    /// - Returns: Modified view
    func removeBorder() -> Self {
        layer.borderWidth = 0
        return self
    }

    /// Applies a thin border with system gray color
    /// - Returns: Modified view
    func thinBorder() -> Self {
        if #available(iOS 13.0, *) {
            return borderedWithRadius(color: .systemGray4, width: 0.5)
        } else {
            return borderedWithRadius(color: .lightGray, width: 0.5)
        }
    }

    /// Applies border on specific edges
    /// - Parameters:
    ///   - edges: Edges to apply border to
    ///   - color: Border color
    ///   - width: Border width
    /// - Returns: Modified view
    func border(edges: UIRectEdge, color: UIColor, width: CGFloat = 1.0) -> Self {
        if edges.contains(.top) {
            addBorderLine(edge: .top, color: color, width: width)
        }
        if edges.contains(.bottom) {
            addBorderLine(edge: .bottom, color: color, width: width)
        }
        if edges.contains(.left) {
            addBorderLine(edge: .left, color: color, width: width)
        }
        if edges.contains(.right) {
            addBorderLine(edge: .right, color: color, width: width)
        }
        return self
    }

    /// Adds a border line to a specific edge
    private func addBorderLine(edge: UIRectEdge, color: UIColor, width: CGFloat) {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.cgColor
        borderLayer.name = "border_\(edge.rawValue)"
        
        // Store edge and width info in the layer for later frame updates
        borderLayer.setValue(edge.rawValue, forKey: "borderEdge")
        borderLayer.setValue(width, forKey: "borderWidth")
        
        // Set initial frame - will be updated in layoutSubviews
        updateBorderLayerFrame(borderLayer, edge: edge, width: width)
        
        layer.addSublayer(borderLayer)
        
        // Ensure frame updates when bounds change
        setNeedsLayout()
    }
    
    /// Updates border layer frame based on current bounds
    private func updateBorderLayerFrame(_ borderLayer: CALayer, edge: UIRectEdge, width: CGFloat) {
        switch edge {
        case .top:
            borderLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: width)
        case .bottom:
            borderLayer.frame = CGRect(x: 0, y: bounds.height - width, width: bounds.width, height: width)
        case .left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        case .right:
            borderLayer.frame = CGRect(x: bounds.width - width, y: 0, width: width, height: bounds.height)
        default:
            break
        }
    }

    /// Updates all border layer frames when bounds change
    func updateBorderLayerFrames() {
        layer.sublayers?.forEach { sublayer in
            guard let name = sublayer.name,
                  name.hasPrefix("border_"),
                  let edgeRawValue = sublayer.value(forKey: "borderEdge") as? UInt,
                  let width = sublayer.value(forKey: "borderWidth") as? CGFloat else {
                return
            }
            
            let edge = UIRectEdge(rawValue: edgeRawValue)
            updateBorderLayerFrame(sublayer, edge: edge, width: width)
        }
    }
    
    /// Removes border lines added with border(edges:color:width:)
    /// - Returns: Modified view
    func removeBorderLines() -> Self {
        layer.sublayers?.removeAll { sublayer in
            sublayer.name?.hasPrefix("border_") == true
        }
        return self
    }
}
