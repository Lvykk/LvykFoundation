//
//  IrregularWidthFlowLayout.swift
//  NeoLine
//
//  Created by Lvyk on 2022/2/10.
//

import UIKit

class IrregularWidthFlowLayout: UICollectionViewFlowLayout {
    @IBInspectable var itemHeight: CGFloat = 0.0

    private var maxContentY: CGFloat = 0.0

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superArray = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else { return nil }

        guard let attributes = NSArray(array: superArray, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }

        maxContentY = sectionInset.top

        var itemX = 0.0

        for i in 0..<attributes.count {
            let attribute = attributes[i]

            let contentW = CGFloat(collectionView.bounds.width - sectionInset.left - sectionInset.right)

            let height = itemHeight == 0 ? attribute.size.height : itemHeight

            if itemX + attribute.size.width >= contentW {
                maxContentY += attribute.frame.size.height + minimumLineSpacing
                itemX = 0.0
            }
            attribute.frame = CGRect(x: itemX, y: maxContentY, width: attribute.size.width, height: height)
            itemX += attribute.size.width + minimumInteritemSpacing
            if i == attributes.count - 1 {
                maxContentY += attribute.frame.size.height + minimumLineSpacing
            }
        }
        return attributes.filter { $0.frame.intersects(rect) }
    }

    override var collectionViewContentSize: CGSize {
        guard let frame = collectionView?.frame else { return .zero }
        return CGSize(width: frame.width, height: maxContentY)
    }
}
