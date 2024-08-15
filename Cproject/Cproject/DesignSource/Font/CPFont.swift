//
//  CPFont.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/07/31.
//

import Foundation
import UIKit
import SwiftUI

enum CPFont { }

extension CPFont {
    enum UIKit {
        static var regular10: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular)
        
        static var regular12: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        static var medium12: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium)
        static var bold12: UIFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        static var regular14: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static var bold14: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        static var medium16: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        static var bold16: UIFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        static var light17: UIFont = UIFont.systemFont(ofSize: 17, weight: .light)
        static var medium17: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        static var bold17: UIFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        static var bold20: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}

extension CPFont {
    enum SwiftUI {
        static var regular10: Font = .system(size: 10, weight: .regular)
        
        static var regular12: Font = .system(size: 12, weight: .regular)
        static var medium12: Font = .system(size: 12, weight: .medium)
        static var bold12: Font = .system(size: 12, weight: .bold)
        
        static var regular14: Font = .system(size: 14, weight: .regular)
        static var bold14: Font = .system(size: 14, weight: .bold)
        
        static var medium16: Font = .system(size: 16, weight: .medium)
        static var bold16: Font = .system(size: 16, weight: .bold)
        
        static var light17: Font = .system(size: 17, weight: .light)
        static var medium17: Font = .system(size: 17, weight: .medium)
        static var bold17: Font = .system(size: 17, weight: .bold)
        
        static var bold20: Font = .system(size: 20, weight: .bold)
    }
}
