//
//  CardViewModelType.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 21.04.2021.
//

import UIKit

protocol CardViewControllerVMType {
    
    // MARK: - Start Setup and Cards
    
    var cardProfiles: [CardProfile] { get }
    var cardState: (point: CGPoint, state: UIGestureRecognizer.State)? { get set }
    
    // MARK: - Cards Animations
    
    func setAnimationBehavoir(forAnimationType animationType: Animation.AnimationType) -> Animation
    func animate(animationType: Animation.AnimationType, animations: @escaping (() -> ()))
    func animate(animationType: Animation.AnimationType, animations: @escaping (() -> ()), completion: ((Bool) -> ())?)
}
