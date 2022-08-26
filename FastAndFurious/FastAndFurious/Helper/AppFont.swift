//
//  AppFont.swift
//  FastAndFurious
//
//  Created by Rahul on 24/08/22.
//

import UIKit

private let familyName = "Lato"

enum AppFont: String {
    case regular = "Regular"
    case medium = "Medium"
    case semiBold = "Semibold"
    case bold = "Bold"
    case extraBold = "ExtraBold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }

    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}
