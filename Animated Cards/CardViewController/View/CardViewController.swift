//
//  ViewController.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 13.04.2021.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Setup Cards
    
    var viewModel: CardViewControllerVMType! {
        willSet(newViewModel) {
            changeLayoutAfterViewModelUpdate(withViewModel: newViewModel)
        }
    }
    enum SetOfCard: Int {
        case yesOrNo, fourAnsrwers
    }
    private var cardVMStack: [CardViewVM] = []
    
    // MARK: - Hepling variable
    
    private var currentCard: CardView!
    private var accessoryView = AccessoryView()
    private var cardViewPositionHandler = CardViewPositionHandler()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - Transform and Layout variable
    
    var scaleForTransform: CGFloat = 1.3
    private var cardWidth: CGFloat = 300.0
    private var cardHeight: CGFloat = 300.0
    private var cardCenterXAnchorConstant: CGFloat = 0.0
    private var cardCenterYAnchorConstant: CGFloat = 0.0
    private var cardCenterXAnchorConstraint = NSLayoutConstraint()
    private var cardCenterYAnchorConstraint = NSLayoutConstraint()
    private var cardWidthAnchorConstraint = NSLayoutConstraint()
    private var cardHeightAnchorConstraint = NSLayoutConstraint()
    
    // MARK: - CardViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CardViewControllerVM()
        for cardProfile in viewModel.cardProfiles {
            cardVMStack.append(CardViewVM(text: cardProfile.text, image: cardProfile.image!, containerViewController: self))
        }
        if !cardVMStack.isEmpty {
            currentCard = CardView(withViewModel: cardVMStack[0])
            prepareCardView(card: currentCard)
        }
        //addAccessoryView()
    }
    
    // MARK: - Initial Layout
    
    private func prepareCardView(card: CardView) {
        view.addSubview(card)
        card.backgroundColor = UIColor.setСolorDependingOnOffset(xCenterOffset: 0)
        cardCenterXAnchorConstant = 0.0
        cardCenterYAnchorConstant = -view.bounds.height
        cardCenterXAnchorConstraint = card.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: cardCenterXAnchorConstant)
        cardCenterYAnchorConstraint = card.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: cardCenterYAnchorConstant)
        cardWidthAnchorConstraint = card.widthAnchor.constraint(equalToConstant: cardWidth)
        cardHeightAnchorConstraint = card.heightAnchor.constraint(equalToConstant: cardHeight)
        NSLayoutConstraint.activate([
            cardCenterXAnchorConstraint,
            cardCenterYAnchorConstraint,
            cardWidthAnchorConstraint,
            cardHeightAnchorConstraint
        ])
        view.layoutIfNeeded()
        animation(card: card, animation: .preparing)
        cardViewPositionHandler.bindViewToViewController(self, currentCard)
    }
    
    func addAccessoryView() {
        view.addSubview(accessoryView)
        NSLayoutConstraint.activate([
            accessoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accessoryView.topAnchor.constraint(equalTo: view.topAnchor),
            accessoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            accessoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Layout Changing After Tap in CardView
    
    func changeLayoutAfterViewModelUpdate(withViewModel viewModel: CardViewControllerVMType) {
        let state = viewModel.cardState?.state
        let point = viewModel.cardState?.point
        if state == .began {
            animation(card: currentCard, animation: .increasing)
            feedbackGenerator.impactOccurred()
        }
        if state == .changed {
            cardViewPositionHandler.activateAnchorPointIfNeeded(with: point!)
            cardViewPositionHandler.updateCardOffset(pointToUpdate: point!)
            cardCenterXAnchorConstraint.constant = cardViewPositionHandler.xCenterOffset
            cardCenterYAnchorConstraint.constant = cardViewPositionHandler.yCenterOffset
            animation(card: currentCard, animation: .drag)
            view.setNeedsLayout()
        }
        if state == .ended {
            if (abs(cardViewPositionHandler.xCenterOffset) >= 170) {
                animation(card: currentCard, animation: .hidding)
            } else {
                animation(card: currentCard, animation: .returning)
            }
            cardViewPositionHandler.disableAnchorPoint()
        }
    }
    
    // MARK: - Layout Animation
    
    private func animation(card: CardView, animation: Animation.AnimationType) {
        if animation == .preparing {
            viewModel.animate(animationType: .preparing) { [unowned self] in
                cardCenterXAnchorConstraint.constant = 0
                cardCenterYAnchorConstraint.constant = 0
                view.layoutIfNeeded()
            }
        }
        if animation == .increasing {
            viewModel.animate(animationType: .increasing) { [unowned self] in
                currentCard.transform = CGAffineTransform.init(scaleX: scaleForTransform, y: scaleForTransform)
                view.layoutIfNeeded()
            }
        }
        if animation == .returning {
            viewModel.animate(animationType: .returning) { [unowned self] in
                cardCenterXAnchorConstraint.constant = 0
                cardCenterYAnchorConstraint.constant = 0
                currentCard.transform = .identity
                currentCard.backgroundColor = UIColor.setСolorDependingOnOffset(xCenterOffset: 0)
                view.layoutIfNeeded()
            }
        }
        if animation == .hidding {
            viewModel.animate(animationType: .hidding) { [unowned self] in
                let leftOrRight = cardViewPositionHandler.xCenterOffset / abs(cardViewPositionHandler.xCenterOffset)
                cardCenterXAnchorConstraint.constant += view.bounds.width * leftOrRight
                currentCard.backgroundColor = UIColor.setСolorDependingOnOffset(xCenterOffset: cardViewPositionHandler.xCenterOffset)
                view.layoutIfNeeded()
            } completion: { [unowned self] _ in
                currentCard.removeFromSuperview() // deinit
                cardVMStack.remove(at: 0)
                if !cardVMStack.isEmpty {
                    currentCard = CardView(withViewModel: self.cardVMStack[0])
                    prepareCardView(card: self.currentCard)
                    //self.accessoryView.removeFromSuperview()
                    //self.addAccessoryView()
                }
            }
        }
        if animation == .drag {
            var multipleTransform = CGAffineTransform.identity
            multipleTransform = multipleTransform.scaledBy(x: scaleForTransform, y: scaleForTransform)
            multipleTransform = multipleTransform.rotated(by: cardViewPositionHandler.angle)
            currentCard.transform = multipleTransform
            currentCard.backgroundColor = UIColor.setСolorDependingOnOffset(xCenterOffset: cardViewPositionHandler.xCenterOffset, yCenterOffset: cardViewPositionHandler.yCenterOffset)
            view.layoutIfNeeded()
        }
    }
}
