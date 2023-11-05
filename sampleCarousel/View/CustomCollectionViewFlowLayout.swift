//
//  CustomCollectionViewFlowLayout.swift
//  sampleCarousel
//
//  Created by apple on 2023/10/28.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var maxX: CGFloat = 0
    
    // セルの位置を設定
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        var previousMaxX: CGFloat = 0.0 //前のセルの右端
        for attributes in layoutAttributes {
            let copiedAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
            
            let collectionViewHeight = collectionView?.bounds.height ?? 0
            let centerY = collectionViewHeight / 2
            copiedAttributes.center = CGPoint(x: copiedAttributes.center.x, y: centerY)
            
            if copiedAttributes.indexPath.item == 0 {
                let inset = (UIScreen.main.bounds.size.width - copiedAttributes.size.width) / 2
                copiedAttributes.center = CGPoint(x: inset + copiedAttributes.size.width / 2, y: centerY)
                previousMaxX = copiedAttributes.frame.maxX
            } else {
                // 最初のセルのサイズは倍なので二個目のセルのminimumLineSpacingは半分
                let spacing = copiedAttributes.indexPath.item == 1 ? minimumLineSpacing / 2 : minimumLineSpacing
                    copiedAttributes.frame.origin.x = previousMaxX + spacing
                previousMaxX = copiedAttributes.frame.maxX
            }
            if newLayoutAttributes.last != nil {
                maxX = copiedAttributes.frame.maxX
            }
            
            newLayoutAttributes.append(copiedAttributes)
        }
        return newLayoutAttributes
    }
    
    // コレクションビューのWidthを変更
    override var collectionViewContentSize: CGSize {
        let defaultSize = super.collectionViewContentSize
        guard collectionView != nil else {
            return defaultSize
        }
        let inset = (UIScreen.main.bounds.size.width - itemSize.width) / 2
        let widthWithInsets = maxX + inset
        
        return CGSize(width: widthWithInsets, height: defaultSize.height)
    }
}
