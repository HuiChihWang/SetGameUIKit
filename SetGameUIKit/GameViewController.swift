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
    
    @IBOutlet weak var dealButton: UIButton! {
        didSet {
            dealButton.layer.cornerRadius = 10
            dealButton.layer.borderWidth = 3
            
            dealButton.superview?.layer.cornerRadius = 10
            dealButton.superview?.layer.borderWidth = 3
        }
    }
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.layer.cornerRadius = 10
            scoreLabel.layer.borderWidth = 3
            
            scoreLabel.superview?.layer.cornerRadius = 10
            scoreLabel.superview?.layer.borderWidth = 3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func more3Card(_ sender: Any) {
        game.dealThreeMoreCards()
        updateView()
    }
    
    @IBAction func newGame(_ sender: Any) {
        game.newGame()
        updateView()
    }
    
    private func updateView() {
        gameBoard.reloadData()
        scoreLabel.text = "\(game.score) Points"
        dealButton.superview?.isHidden = game.numberOfLeftCards == 0
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
        updateView()
    }
}

