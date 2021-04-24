//
//  AnimationType.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 18.04.2021.
//

import UIKit

struct Animation {
    
    let withDuration: TimeInterval
    let delay: TimeInterval
    let usingSpringWithDamping: CGFloat
    let initialSpringVelocity: CGFloat
    let options: UIView.AnimationOptions
    
    enum AnimationType {
        case preparing
        case increasing
        case returning
        case hidding
        case drag
    }
    
    init(withDuration: TimeInterval, delay: TimeInterval, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: UIView.AnimationOptions) {
        self.withDuration = withDuration
        self.delay = delay
        self.usingSpringWithDamping = usingSpringWithDamping
        self.initialSpringVelocity = initialSpringVelocity
        self.options = options
    }
}
