//
//  ViewController.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/27.
//

import UIKit

class GameViewController: UIViewController {
    
    private var game = SetGame()
    
    @IBOutlet weak var gameBoard: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func more3Card(_ sender: Any) {
        game.dealThreeMoreCards()
        gameBoard.reloadData()
    }
    
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        game.cardsOnTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CardViewCell.self)", for: indexPath)
        
        let card = game.cardsOnTable[indexPath.row]
        (cell as? CardViewCell)?.configure(with: card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game.selectCard(by: indexPath.row)
        collectionView.reloadData()
    }
}

