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
    }
    
    private func setUpLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: String(describing: CarouselViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: CarouselViewCell.self))
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height / 2)
    }
}

extension ViewController: UICollectionViewDelegate {
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:  CarouselViewCell.self), for: indexPath) as! CarouselViewCell
        return cell
    }
}
