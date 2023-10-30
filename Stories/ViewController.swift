//
//  ViewController.swift
//  Stories
//
//  Created by Ботурбек Имомдодов on 30/10/23.
//

import UIKit
enum StoriesInteractionAreas {
    case right
    case left
    case center
}
class ViewController: UIViewController {
    private let colors:[UIColor] = [.red,.green,.blue]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
    }
    private func takeArea(for position:CGPoint)->StoriesInteractionAreas {
        let screenWidth = self.view.frame.width
        if position.x <= screenWidth / 3 {
            return .left
        }
        else if position.x >= self.view.frame.width - screenWidth / 3 {
            return .right
        }
        else{
            return .center
        }
    }
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as! CollectionViewCell
        cell.storiesSwipeDelegate = self
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
extension ViewController:StoriesSwipeDelegate {
    func swipeTo(touchedPosition: CGPoint) {
        let area = takeArea(for: touchedPosition)
        let pageWidth = collectionView.frame.width
        let page:Int = Int(collectionView.contentOffset.x / pageWidth)
        switch area {
        case .right:
            guard page + 1 != colors.count else {
                return
            }
            collectionView.scrollToItem(at: IndexPath(row: page + 1, section: 0), at: .right, animated: true)
        case .left:
            guard page != 0 else {
                return
            }
            collectionView.scrollToItem(at: IndexPath(row: page - 1, section: 0), at: .right, animated: true)
        case .center:
            print("heyhey")
        }
    }
    
    
}
