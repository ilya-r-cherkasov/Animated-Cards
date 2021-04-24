//
//  Color.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 18.04.2021.
//

import UIKit

extension UIColor {
    static func setСolorDependingOnOffset(xCenterOffset: CGFloat = 0.0, yCenterOffset: CGFloat = 0.0) -> UIColor {
        let k = (xCenterOffset / UIScreen.main.bounds.size.width) * 1.5
        let l = (yCenterOffset / UIScreen.main.bounds.size.height) * 1.5
        let color = UIColor(red: 1.0 - k - l, green: 1.0 + k + l, blue: 1.0 - abs(k) - abs(l), alpha: 1.0)
        return color
    }
    static func setСolorDependingOnOffset(centerOffset: (x: CGFloat, y: CGFloat)) -> UIColor {
        return UIColor.setСolorDependingOnOffset(xCenterOffset: centerOffset.x, yCenterOffset: centerOffset.y)
    }
}
