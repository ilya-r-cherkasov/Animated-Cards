//
//  SeconAView.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 18.04.2021.
//

import UIKit

class AccessoryView: UIView {
    
    private var views = [CustomView(m: -1, n: -1), CustomView(m: -1, n: 1), CustomView(m: 1, n: -1), CustomView(m: 1, n: 1)]
    var viewModel: AccessoryViewVMType!
    private let offset: CGFloat = 2.2
    private let widthCoeff: CGFloat = 1.6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        self.viewModel = AccessoryViewVM()
    }
    
    func setConstraits() {
        for view in views {
            addSubview(view)
            view.backgroundColor = .white
            view.textView.text = viewModel.items[0]
            viewModel.items.remove(at: 0)
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: view.m * self.frame.width / offset),
                view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: view.n * self.frame.height / offset),
                view.widthAnchor.constraint(equalToConstant: self.frame.width / widthCoeff),
                view.heightAnchor.constraint(equalToConstant: self.frame.width / widthCoeff),
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraits()
    }
    
}

class CustomView: UIView {
    
    var m: CGFloat = 0.0
    var n: CGFloat = 0.0
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        addSubview(textView)
    }
    
    init(m: CGFloat, n: CGFloat) {
        print(#function)
        super.init(frame: .zero)
        self.m = m
        self.n = n
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        textView.backgroundColor = .red
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -m * self.frame.width / 5),
            textView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -n * self.frame.height / 5),
            textView.widthAnchor.constraint(equalToConstant: 120),
            textView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
