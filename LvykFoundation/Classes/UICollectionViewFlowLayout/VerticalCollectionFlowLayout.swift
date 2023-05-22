//
//  VerticalCollectionFlowLayout.swift
//  NeoLine
//
//  Created by Lvyk on 2022/2/9.
//

import UIKit

class VerticalCollectionFlowLayout: UICollectionViewFlowLayout {
    @IBInspectable var colCount: Int = 4
    @IBInspectable var itemHeight: CGFloat = 50.0

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superArray = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else { return nil }

        guard let attributes = NSArray(array: superArray, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }

        var itemY = sectionInset.top

        for i in 0..<attributes.count {
            let attribute = attributes[i]
            // Total width
            let contentW = CGFloat(collectionView.bounds.width - sectionInset.left - sectionInset.right)
            // Width of each item
            let itemW = (contentW - CGFloat(colCount - 1) * minimumInteritemSpacing) / CGFloat(colCount)

            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(i % colCount)

            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemHeight)

            if i % colCount == colCount - 1 {
                itemY += itemHeight + sectionInset.top + minimumLineSpacing
            }
        }

        return attributes.filter { $0.frame.intersects(rect) }
    }

    override var collectionViewContentSize: CGSize {
        guard let frame = collectionView?.frame else { return .zero }
        let itemNum = collectionView?.numberOfItems(inSection: 0) ?? 0
        let lineCount = ceil(CGFloat(itemNum) / CGFloat(colCount))
        let height: CGFloat = lineCount * CGFloat(itemHeight) + sectionInset.top + sectionInset.bottom + (lineCount - 1) * minimumLineSpacing
        return CGSize(width: frame.width, height: height)
    }
}
