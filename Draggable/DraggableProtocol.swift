//
//  DraggableProtocol.swift
//  DraggableTest
//
//  Created by Bay Phillips on 9/27/15.
//  Copyright © 2015 Bay Phillips. All rights reserved.
//

import UIKit

protocol Draggable: class {
    var view: UIView { get }
    var initialLocation: CGPoint { get set }

    func registerDraggability() -> Void
    func removeDraggability() -> Void
    func didPress(_ pressGesture: UILongPressGestureRecognizer) -> Void
    func didPan(_ panGesture: UIPanGestureRecognizer) -> Void
}
