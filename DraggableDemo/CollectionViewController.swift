//
//  CollectionViewController.swift
//  DraggableTest
//
//  Created by Bay Phillips on 9/26/15.
//  Copyright © 2015 Bay Phillips. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.size.width, height: 200)
        
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let draggableCell: DraggableCell = collectionView.dequeueReusableCell(withReuseIdentifier: DraggableCell.identifier, for: indexPath) as! DraggableCell
        draggableCell.textLabel.text = "Row \(indexPath.row)"
        
        switch indexPath.row % 3 {
        case 0:
            draggableCell.backgroundColor = UIColor.blue
            break
        case 1:
            draggableCell.backgroundColor = UIColor.purple
            break
        case 2:
            draggableCell.backgroundColor = UIColor.yellow
            break
        default:
            break
        }
        return draggableCell
    }
}
