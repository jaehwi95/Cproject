//
//  NumericExtensions.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/08/02.
//

import Foundation

extension Numeric {
    var moneyString: String {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return (formatter.string(for: self) ?? "") + "원"
    }
}
