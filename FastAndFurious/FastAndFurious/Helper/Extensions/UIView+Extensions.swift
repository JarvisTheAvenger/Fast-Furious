//
//  UIView+Extensions.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

extension UIView {
    func addGradientToView(colors: [UIColor],
                           rect: CGRect,
                           isVertical: Bool,
                           locations: [NSNumber]? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = isVertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
        gradientLayer.frame = rect
        gradientLayer.colors = colors.map({$0.cgColor})
        if let l = locations {
            gradientLayer.locations = l
        }

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}
