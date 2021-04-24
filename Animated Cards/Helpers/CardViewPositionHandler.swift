//
//  Measure.swift
//  Animated Cards
//
//  Created by Ilya Cherkasov on 24.04.2021.
//

import UIKit

class CardViewPositionHandler {
    
    var nestingViewController: UIViewController!
    var bindingView: UIView!
    var anchorPointForCalculateOffset: CGPoint?
    var xCenterOffset: CGFloat = 0.0 {
        willSet {
            angle = xCenterOffset / UIScreen.main.bounds.width
        }
    }
    var yCenterOffset: CGFloat = 0.0
    
    typealias Radians = CGFloat
    var angle: Radians = 0.0
    
    func bindViewToViewController(_ nestingViewController: UIViewController, _ bindingCardView: CardView) {
        self.nestingViewController = nestingViewController
        self.bindingView = bindingCardView
    }
    
    func activateAnchorPointIfNeeded(with point: CGPoint) {
        if anchorPointForCalculateOffset == nil {
            let point = nestingViewController.view.coordinateSpace.convert(point, from: bindingView.coordinateSpace)
            anchorPointForCalculateOffset = point
        }
    }
    
    func disableAnchorPoint() {
        anchorPointForCalculateOffset = nil
    }
    
    func updateCardOffset(pointToUpdate: CGPoint) {
        guard let anchorPointForCalculateOffset = anchorPointForCalculateOffset else { return }
        let point = convertCoordinateSpace(pointToConvert: pointToUpdate)
        let offset = centerOffset(from: anchorPointForCalculateOffset, to: point)
        xCenterOffset = offset.x
        yCenterOffset = offset.y
    }
    
    private func convertCoordinateSpace(pointToConvert: CGPoint) -> CGPoint {
        let point = nestingViewController.view.coordinateSpace.convert(pointToConvert, from: bindingView.coordinateSpace)
        return point
    }
    
    private func xCenterOffset(from: CGPoint, to: CGPoint) -> CGFloat {
        xCenterOffset = to.x - from.x
        return xCenterOffset
    }
    
    private func yCenterOffset(from: CGPoint, to: CGPoint)  -> CGFloat {
        yCenterOffset = to.y - from.y
        return yCenterOffset
    }
    
    private func centerOffset(from: CGPoint, to: CGPoint) -> (x: CGFloat, y: CGFloat) {
        let x = xCenterOffset(from: from, to: to)
        let y = yCenterOffset(from: from, to: to)
        return (x, y)
    }
    
    private func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    private func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}
