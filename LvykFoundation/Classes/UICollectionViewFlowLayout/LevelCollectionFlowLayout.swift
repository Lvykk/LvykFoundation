//
//  LevelCollectionFlowLayout.swift
//  NeoLine
//
//  Created by Lvyk on 2021/12/17.
//

import UIKit

class LevelCollectionFlowLayout: UICollectionViewFlowLayout {
    var colCount: Int = 4

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superArray = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else { return nil }

        guard let attributes = NSArray(array: superArray, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }

        for i in 0..<attributes.count {
            let attribute = attributes[i]
            // Total width
            let contentW = CGFloat(collectionView.bounds.width - sectionInset.left - sectionInset.right)
            // Width of each item
            let itemW = (contentW - CGFloat(colCount - 1) * minimumInteritemSpacing) / CGFloat(colCount)
            // itemX
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(i)
            attribute.frame = CGRect(x: itemX, y: 0, width: itemW, height: collectionView.bounds.height)
        }

        return attributes.filter { $0.frame.intersects(rect) }
    }

    override var collectionViewContentSize: CGSize {
        guard let frame = self.collectionView?.frame else { return .zero }
        let itemW: CGFloat = (frame.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing)
        let itemNum = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        let width: CGFloat = ceil(CGFloat(itemNum) / CGFloat(self.colCount)) * CGFloat(itemW + self.minimumInteritemSpacing) + self.sectionInset.left + self.sectionInset.right
        return CGSize(width: width, height: frame.height)
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        let pageWidth = collectionView.bounds.width - sectionInset.left - sectionInset.right // width + space
        let currentOffset = collectionView.contentOffset.x
        let targetOffset = proposedContentOffset.x
        var newTargetOffset = 0

        if targetOffset > currentOffset {
            newTargetOffset = Int(ceilf(Float(currentOffset / pageWidth)) * Float(pageWidth))
        } else {
            newTargetOffset = Int(floorf(Float(currentOffset / pageWidth)) * Float(pageWidth))
        }

        if newTargetOffset < 0 {
            newTargetOffset = 0
        } else if newTargetOffset > Int(collectionView.contentSize.width) {
            newTargetOffset = Int(collectionView.contentSize.width)
        }
        return CGPoint(x: CGFloat(newTargetOffset), y: proposedContentOffset.y)
    }
}
