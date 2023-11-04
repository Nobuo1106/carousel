//
//  ViewController.swift
//  sampleCarousel
//
//  Created by apple on 2023/09/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        collectionView.reloadData()
    }
    
    private func setUpLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: String(describing: CarouselViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: CarouselViewCell.self))
        let layout = CustomCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UIScreen.main.bounds.width / 3
        layout.itemSize = CGSize(width: collectionView.bounds.width / 5, height: collectionView.bounds.height / 5)
        collectionView.collectionViewLayout = layout
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let collectionViewCenterX = scrollView.bounds.size.width / 2

        for cell in collectionView.visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell) else { continue }
            let cellCenter = collectionView.layoutAttributesForItem(at: indexPath)!.center.x - offsetX
            let distance = abs(collectionViewCenterX - cellCenter)
            let normalizedDistance = distance / collectionViewCenterX
            var scale = 0.0
            
            // 一番目のセルだけサイズが大きいのでスケールを半分それ以外は中心でサイズを2倍
            if indexPath.item == 0 {
                scale = 1 - normalizedDistance
                scale = max(scale, 0.5)
            } else {
                scale = 2 - normalizedDistance
                scale = min(scale, 2.0)
            }
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:  CarouselViewCell.self), for: indexPath) as! CarouselViewCell
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.bounds.width / 2.5, height: collectionView.bounds.height / 2.5)
        } else {
            return CGSize(width: collectionView.bounds.width / 5, height: collectionView.bounds.height / 5)
        }
    }
}
