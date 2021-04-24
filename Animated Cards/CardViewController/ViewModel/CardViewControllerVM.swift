//
//  CardViewViewModel.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 21.04.2021.
//

import UIKit

class CardViewControllerVM: CardViewControllerVMType {
    
    // MARK: - Start Setup and Update Cards
    
    var cardState: (point: CGPoint, state: UIGestureRecognizer.State)?
    var cardProfiles: [CardProfile] = [CardProfile(text: "Что изображено на рисунке?", image: UIImage(named: "cpu")),
                                      CardProfile(text: "А это что такое?", image: UIImage(named: "gpu")),
                                      CardProfile(text: "Угадайте, что это?", image: UIImage(named: "cooler")),
                                      CardProfile(text: "А это??", image: UIImage(named: "memory"))
    ]
    
    init(point: CGPoint? = nil, state: UIGestureRecognizer.State? = nil) {
        if point != nil && state != nil {
            self.cardState = (point: point!, state: state!)
        }
    }
    
    // MARK: - Cards Animation
    
    func setAnimationBehavoir(forAnimationType animationType: Animation.AnimationType) -> Animation {
        switch animationType {
        case .preparing:
            return Animation(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [])
        case .increasing:
            return Animation(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [.allowUserInteraction])
        case .returning:
            return Animation(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: [.allowUserInteraction])
        case .hidding:
            return Animation(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: [])
        case .drag:
            return Animation(withDuration: 0.0, delay: 0.0, usingSpringWithDamping: 0.0, initialSpringVelocity: 0.0, options: [])
        }
    }
    
    func animate(animationType: Animation.AnimationType, animations: @escaping (() -> ()), completion: ((Bool) -> ())? = nil) {
        let animation = setAnimationBehavoir(forAnimationType: animationType)
        UIView.animate(withDuration: animation.withDuration,
                       delay: animation.delay,
                       usingSpringWithDamping: animation.usingSpringWithDamping,
                       initialSpringVelocity: animation.initialSpringVelocity,
                       options: animation.options,
                       animations: animations,
                       completion: { success in
                        completion?(success)
                       })
    }
    
    func animate(animationType: Animation.AnimationType, animations: @escaping (() -> ())) {
        animate(animationType: animationType, animations: animations, completion: nil)
    }
}
