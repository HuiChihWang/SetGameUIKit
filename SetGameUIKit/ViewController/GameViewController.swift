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
    
    @IBOutlet weak var scoreLabel: UILabel! {
        didSet {
            scoreLabel.layer.cornerRadius = 10
            scoreLabel.layer.borderWidth = 3
            
            scoreLabel.superview?.layer.cornerRadius = 10
            scoreLabel.superview?.layer.borderWidth = 3
        }
    }

    
    @IBOutlet weak var leftNumberLabel: UILabel! {
        didSet {
            leftNumberLabel.layer.cornerRadius = 10
            leftNumberLabel.layer.borderWidth = 3
            
            leftNumberLabel.superview?.layer.cornerRadius = 10
            leftNumberLabel.superview?.layer.borderWidth = 3
        }
    }
    
    @IBAction func showInfo(_ sender: Any) {
        let alert = UIAlertController(title: "Instruction", message: "Deal 3 more cards: swipe down\n Shuffle cards: circle the screen\n If you want to know how to play, please view the tutorial video", preferredStyle: .alert)
        
        let viewWebsite = UIAlertAction(title: "Tutorial", style: .cancel) { _ in
            
            if let url = URL(string: "https://www.youtube.com/watch?v=azaArSs-i0c&t=2s") {
                UIApplication.shared.open(url)
            }
        }
        
        alert.addAction(viewWebsite)
        
        let cancel = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(cancel)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        updateView()
    }
    
    @IBAction func more3Card(_ sender: Any) {
        game.dealThreeMoreCards()
        updateView()
    }
    
    @IBAction func reShuffleCards(_ sender: Any) {
        if let rotationGesture = sender as? UIRotationGestureRecognizer {
            
            if abs(rotationGesture.rotation) > .pi * 0.4 {
                print("trigger: \(rotationGesture.rotation)")
                game.reDealCards()
                updateView()
            }
        }
    }
    
    @IBAction func newGame(_ sender: Any) {
        game.newGame()
        updateView()
    }
    
    private func updateView() {
        gameBoard.reloadData()
        scoreLabel.text = "\(game.score) Points"
        leftNumberLabel.text = "\(game.numberOfLeftCards) Cards Left"
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

