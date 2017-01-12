//
//  Draggable+UIGestureRecognizer.swift
//  DraggableTest
//
//  Created by Bay Phillips on 9/27/15.
//  Copyright © 2015 Bay Phillips. All rights reserved.
//

import UIKit

extension UIGestureRecognizer {
    fileprivate class ClosureWrapper: NSObject {
        let handler: (UIGestureRecognizer) -> Void
        
        init(handler: @escaping (UIGestureRecognizer) -> Void) {
            self.handler = handler
        }
    }
    
    class GestureDelegate: NSObject, UIGestureRecognizerDelegate {
        static var delegateKey: String = "delegateKey"
        @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return gestureRecognizer.delegate is GestureDelegate && otherGestureRecognizer.delegate is GestureDelegate
        }
        
        @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            return true
        }
        
        @objc func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
    
    fileprivate var multiDelegate: GestureDelegate {
        get {
            return objc_getAssociatedObject(self, &GestureDelegate.delegateKey) as! GestureDelegate
        }
        set {
            objc_setAssociatedObject(self, &GestureDelegate.delegateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate static var handlerKey: String = "handlerKey"
    var handler: (UIGestureRecognizer) -> Void {
        get {
            let closureWrapper: ClosureWrapper = objc_getAssociatedObject(self, &UIGestureRecognizer.handlerKey) as! ClosureWrapper
            return closureWrapper.handler
        }
        set {
            self.addTarget(self, action: #selector(UIGestureRecognizer.handleAction))
            self.multiDelegate = GestureDelegate()
            self.delegate = self.multiDelegate
            objc_setAssociatedObject(self, &UIGestureRecognizer.handlerKey, ClosureWrapper(handler: newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func handleAction() {
        self.handler(self)
    }
}
