//
//  Draggable+UIView.swift
//  DraggableTest
//
//  Created by Bay Phillips on 9/27/15.
//  Copyright © 2015 Bay Phillips. All rights reserved.
//

import UIKit

extension Draggable where Self: UIView {
    var view: UIView { get { return self } }
    var parentView: UIView? { get { return self.view.superview } }
    
    func registerDraggability() {
        let panGesture = UIPanGestureRecognizer()
        panGesture.handler = { gesture in
            self.didPan(gesture as! UIPanGestureRecognizer)
        }
        
        self.view.addGestureRecognizer(panGesture)
        
        let pressGesture = UILongPressGestureRecognizer()
        pressGesture.minimumPressDuration = 0.001
        pressGesture.handler = { gesture in
            self.didPress(gesture as! UILongPressGestureRecognizer)
        }
        
        self.view.addGestureRecognizer(pressGesture)
    }
    
    func removeDraggability() {
        guard self.gestureRecognizers != nil else {
            return
        }
        
        let _ = self.gestureRecognizers!
            .filter({ $0.delegate is UIGestureRecognizer.GestureDelegate })
            .map({ self.removeGestureRecognizer($0) })
    }
    
    func didPress(_ pressGesture: UILongPressGestureRecognizer) {
        switch pressGesture.state {
        case UIGestureRecognizerState.began:
            self.initialLocation = self.view.center
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.parentView?.bringSubview(toFront: self.view)
                self.view.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
            })
            break
        case UIGestureRecognizerState.cancelled, UIGestureRecognizerState.ended, UIGestureRecognizerState.failed:
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            break
        default:
            break
        }
    }
    
    func didPan(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: self.parentView)
        self.view.center = CGPoint(x: self.initialLocation.x + translation.x, y: self.initialLocation.y + translation.y)
    }
}
