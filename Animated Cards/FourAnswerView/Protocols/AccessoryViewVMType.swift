//
//  AccessoryViewViewModelType.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 21.04.2021.
//

import Foundation

protocol AccessoryViewVMType {
    var items: [String] { get set }
    var type: CardViewController.SetOfCard { get set }
}
