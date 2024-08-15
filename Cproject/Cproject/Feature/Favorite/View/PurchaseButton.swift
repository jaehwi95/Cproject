//
//  PurchaseButton.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/02.
//

import UIKit

final class PurchaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = CPColor.UIKit.blue.cgColor
        setTitleColor(CPColor.UIKit.blue, for: .normal)
        setTitle("구매하기", for: .normal)
    }
}
