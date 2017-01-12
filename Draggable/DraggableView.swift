//
//  DraggableView.swift
//  DraggableTest
//
//  Created by Bay Phillips on 9/27/15.
//  Copyright © 2015 Bay Phillips. All rights reserved.
//

import UIKit

protocol DraggableViewDelegate: class {
    func draggableViewDidSelect(view: DraggableView)
    func draggableViewDidMove(view: DraggableView)
}

class DraggableView: UIView, Draggable {

    var initialLocation: CGPoint = CGPoint.zero
    weak var delegate:DraggableViewDelegate?

    override func didMoveToSuperview() {
        if self.superview != nil {
            self.registerDraggability()
        } else {
            self.removeDraggability()
        }
    }
}

