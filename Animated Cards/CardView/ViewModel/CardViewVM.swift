//
//  CardViewViewModel.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 21.04.2021.
//

import UIKit

class CardViewVM: CardViewVMType {
    
    var text: String
    var image: UIImage
    var containerViewController: UIViewController?
    
    var cardState: (point: CGPoint, state: UIGestureRecognizer.State)?
    
    func createCardViewControllerViewModel(point: CGPoint, state: UIGestureRecognizer.State) -> CardViewControllerVMType {
        return CardViewControllerVM.init(point: point, state: state)
    }
    
    init(text: String, image: UIImage, containerViewController: UIViewController?) {
        self.text = text
        self.image = image
        self.containerViewController = containerViewController
    }
}
