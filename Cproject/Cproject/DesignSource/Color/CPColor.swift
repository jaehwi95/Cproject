//
//  CPColor.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/07/31.
//

import Foundation
import UIKit
import SwiftUI

enum CPColor { }

extension CPColor {
    enum UIKit {
        static var black: UIColor = UIColor(resource: .pBlack)
        static var blue: UIColor = UIColor(resource: .pBlue)
        static var coral: UIColor = UIColor(resource: .pCoralRed)
        static var teal: UIColor = UIColor(resource: .pDarkTeal)
        static var lavender: UIColor = UIColor(resource: .pLavenderBlue)
        static var pink: UIColor = UIColor(resource: .pPink)
        static var red: UIColor = UIColor(resource: .pRed)
        static var white: UIColor = UIColor(resource: .pWhite)
        static var yellow: UIColor = UIColor(resource: .pYellow)
        static var gray3Cool: UIColor = UIColor(resource: .pGray3Cool)
        static var gray1: UIColor = UIColor(resource: .pGray1)
        static var gray2: UIColor = UIColor(resource: .pGray2)
        static var gray5: UIColor = UIColor(resource: .pGray5)
        static var grayIcon: UIColor = UIColor(resource: .pGrayIcon)
        static var gray0: UIColor = UIColor(resource: .pGray0)
    }
}

extension CPColor {
    enum SwiftUI {
        static var black: Color = Color(.pBlack)
        static var blue: Color = Color(.pBlue)
        static var coral: Color = Color(.pCoralRed)
        static var teal: Color = Color(.pDarkTeal)
        static var lavender: Color = Color(.pLavenderBlue)
        static var pink: Color = Color(.pPink)
        static var red: Color = Color(.pRed)
        static var white: Color = Color(.pWhite)
        static var yellow: Color = Color(.pYellow)
        static var gray3Cool: Color = Color(.pGray3Cool)
        static var gray1: Color = Color(.pGray1)
        static var gray2: Color = Color(.pGray2)
        static var gray5: Color = Color(.pGray5)
        static var grayIcon: Color = Color(.pGrayIcon)
        static var gray0: Color = Color(.pGray0)
    }
}
