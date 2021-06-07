//
//  CardDemoControllerViewController.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/30.
//

import UIKit

class CardDemoControllerViewController: UIViewController {

    @IBOutlet weak var cardView: GameCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardView.card = GameCard(shape: .triangle, shading: .striped, number: .three, color: .red)
    }

}
