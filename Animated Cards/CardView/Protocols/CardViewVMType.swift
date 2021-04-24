//
//  CardViewViewModelType.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 21.04.2021.
//

import UIKit

protocol CardViewVMType {
    var text: String { get }
    var image: UIImage { get }
    var containerViewController: UIViewController? { get set }
    func createCardViewControllerViewModel(point: CGPoint, state: UIGestureRecognizer.State) -> CardViewControllerVMType
}
