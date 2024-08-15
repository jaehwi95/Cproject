//
//  CPImage.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/07/31.
//

import Foundation
import UIKit
import SwiftUI

enum CPImage { }

extension CPImage {
    enum UIKit {
        static var close: UIImage = UIImage(resource: .close)
        static var down: UIImage = UIImage(resource: .down)
        static var favoriteOff: UIImage = UIImage(resource: .favoriteOff)
        static var favoriteOn: UIImage = UIImage(resource: .favoriteOn)
        static var home: UIImage = UIImage(resource: .home)
        static var left: UIImage = UIImage(resource: .left)
        static var next: UIImage = UIImage(resource: .next)
        static var topBtn: UIImage = UIImage(resource: .topBtn)
        
        // buttons
        static var buttonActivate: UIImage = UIImage(resource: .btnActivate)
        static var buttonComplete: UIImage = UIImage(resource: .btnComplete)
        
        // categories
        static var category1Big: UIImage = UIImage(resource: .category1Big)
        static var category1Small: UIImage = UIImage(resource: .category1Small)
        static var category2Big: UIImage = UIImage(resource: .category2Big)
        static var category2Small: UIImage = UIImage(resource: .category2Small)
        static var category3Big: UIImage = UIImage(resource: .category3Big)
        static var category3Small: UIImage = UIImage(resource: .category3Small)
        static var category4Big: UIImage = UIImage(resource: .category4Big)
        static var category4Small: UIImage = UIImage(resource: .category4Small)
        static var category5Big: UIImage = UIImage(resource: .category5Big)
        static var category5Small: UIImage = UIImage(resource: .category5Small)
        static var category6Big: UIImage = UIImage(resource: .category6Big)
        static var category6Small: UIImage = UIImage(resource: .category6Small)
        static var category7Big: UIImage = UIImage(resource: .category7Big)
        static var category7Small: UIImage = UIImage(resource: .category7Small)
        static var category8Big: UIImage = UIImage(resource: .category8Big)
        static var category8Small: UIImage = UIImage(resource: .category8Small)
        
        // slide
        static var slide1: UIImage = UIImage(resource: .slide1)
        static var slide2: UIImage = UIImage(resource: .slide2)
        static var slide3: UIImage = UIImage(resource: .slide3)
    }
}

extension CPImage {
    enum SwiftUI {
        static var close: Image = Image(.close)
        static var down: Image = Image(.down)
        static var favoriteOff: Image = Image(.favoriteOff)
        static var favoriteOn: Image = Image(.favoriteOn)
        static var home: Image = Image(.home)
        static var left: Image = Image(.left)
        static var next: Image = Image(.next)
        static var topBtn: Image = Image(.topBtn)
        
        // buttons
        static var buttonActivate: Image = Image(.btnActivate)
        static var buttonComplete: Image = Image(.btnComplete)
        
        // categories
        static var category1Big: Image = Image(.category1Big)
        static var category1Small: Image = Image(.category1Small)
        static var category2Big: Image = Image(.category2Big)
        static var category2Small: Image = Image(.category2Small)
        static var category3Big: Image = Image(.category3Big)
        static var category3Small: Image = Image(.category3Small)
        static var category4Big: Image = Image(.category4Big)
        static var category4Small: Image = Image(.category4Small)
        static var category5Big: Image = Image(.category5Big)
        static var category5Small: Image = Image(.category5Small)
        static var category6Big: Image = Image(.category6Big)
        static var category6Small: Image = Image(.category6Small)
        static var category7Big: Image = Image(.category7Big)
        static var category7Small: Image = Image(.category7Small)
        static var category8Big: Image = Image(.category8Big)
        static var category8Small: Image = Image(.category8Small)
        
        // slide
        static var slide1: Image = Image(.slide1)
        static var slide2: Image = Image(.slide2)
        static var slide3: Image = Image(.slide3)
    }
}
