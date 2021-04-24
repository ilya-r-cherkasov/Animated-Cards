//
//  CardView.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 13.04.2021.
//

import UIKit

class CardView: UIView {
    
    var viewModel: CardViewVMType!
    let gesture = UILongPressGestureRecognizer()
    var text: String? {
        willSet(text) {
            textView.text = text
        }
    }
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 25)
        textView.layer.cornerRadius = 5.0
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        let sideSpace: CGFloat = 10.0
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideSpace),
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: sideSpace),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideSpace),
        ])
        textView.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        textView.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        let sideSpace: CGFloat = 10.0
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: sideSpace),
            imageView.centerXAnchor.constraint(equalTo: textView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -sideSpace),
        ])
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addGesture()
        textView.text = viewModel?.text
        imageView.image = viewModel?.image
    }
    
    init(withViewModel viewModel: CardViewVMType) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        addGesture()
        self.viewModel = viewModel
        textView.text = viewModel.text
        imageView.image = viewModel.image
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT")
    }
    
    @objc func tapInCard() {
        let parentController = viewModel.containerViewController as! CardViewController
        parentController.viewModel = viewModel?.createCardViewControllerViewModel(point: gesture.location(in: self), state: gesture.state)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        if imageView.image != nil {
            let k = (imageView.image?.size.height)! / (imageView.image?.size.width)!
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: k).isActive = true
        }
    }
    
    private func addGesture() {
        gesture.addTarget(self, action: #selector(tapInCard))
        gesture.minimumPressDuration = 0.0
        gesture.numberOfTapsRequired = 0
        self.addGestureRecognizer(gesture)
    }
}
