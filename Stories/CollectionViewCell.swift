//
//  CollectionViewCell.swift
//  Stories
//
//  Created by Ботурбек Имомдодов on 30/10/23.
//

import UIKit
protocol StoriesSwipeDelegate {
    func swipeTo(touchedPosition:CGPoint)
}
class CollectionViewCell: UICollectionViewCell {
    static let id = "CollectionViewCell"
    var storiesSwipeDelegate:StoriesSwipeDelegate?
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: contentView)
            storiesSwipeDelegate?.swipeTo(touchedPosition: position)
        }
    }
}
