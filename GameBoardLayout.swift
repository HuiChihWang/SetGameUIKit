//
//  GameBoardLayout.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/31.
//

import UIKit

class GameBoardLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        let cellsPerRow: CGFloat = 3
        let widthMargin = sectionInset.left + sectionInset.right + collectionView!.safeAreaInsets.left + collectionView!.safeAreaInsets.right + minimumInteritemSpacing * (cellsPerRow - 1)
        let availableWidth = collectionView!.bounds.width - widthMargin
        let itemWidth = availableWidth / cellsPerRow
        
        let cellsPerColumn = (CGFloat(collectionView!.numberOfItems(inSection: 0)) / (cellsPerRow)).rounded(.up)
        let heightMargin = sectionInset.top + sectionInset.bottom + collectionView!.safeAreaInsets.top + collectionView!.safeAreaInsets.bottom + minimumLineSpacing * (cellsPerColumn - 1)
        let availableHeight = collectionView!.bounds.height - heightMargin
        let itemHeight = availableHeight / cellsPerColumn
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

}
