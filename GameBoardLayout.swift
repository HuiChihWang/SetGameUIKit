//
//  GameBoardLayout.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/31.
//

import UIKit

class GameBoardLayout: UICollectionViewFlowLayout {
    private var gridTemplate: CGSize {
        let masterNumber: CGFloat = 3
        let slaveNumber = (CGFloat(collectionView!.numberOfItems(inSection: 0)) / (masterNumber)).rounded(.up)
        
        if isLandScapeMode {
            return CGSize(width: slaveNumber, height: masterNumber)
        }
        
        return CGSize(width: masterNumber, height: slaveNumber)
    }
    
    private var size: CGSize {
        collectionView!.bounds.size
    }
    
    private var isLandScapeMode: Bool {
        UIDevice.current.orientation.isLandscape
    }
    
    private var spacing: CGSize {
        isLandScapeMode ? CGSize(width: minimumLineSpacing, height: minimumInteritemSpacing) : CGSize(width: minimumInteritemSpacing, height: minimumLineSpacing)
    }
    
    override func prepare() {
        super.prepare()
        
        scrollDirection = isLandScapeMode ? .horizontal : .vertical
        
        let widthMargin = sectionInset.left + sectionInset.right + collectionView!.safeAreaInsets.left + collectionView!.safeAreaInsets.right + spacing.width * (gridTemplate.width - 1)
        
        let heightMargin = sectionInset.top + sectionInset.bottom + collectionView!.safeAreaInsets.top + collectionView!.safeAreaInsets.bottom + spacing.height * (gridTemplate.height - 1)

        let availableWidth = size.width - widthMargin
        let availableHeight = size.height - heightMargin

        let itemWidth = availableWidth / gridTemplate.width
        let itemHeight = availableHeight / gridTemplate.height
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
    }

}
