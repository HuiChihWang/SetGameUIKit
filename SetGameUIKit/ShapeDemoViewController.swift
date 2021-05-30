//
//  ShapeDemoViewController.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/30.
//

import UIKit

class ShapeDemoViewController: UIViewController {

    @IBOutlet weak var ovalView: ShapeView!
    @IBOutlet weak var diamondView: ShapeView!
    @IBOutlet weak var squiggleView: ShapeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ovalView.drawingAttribute = ShapeView.DrawingProperty(shape: .oval)
        diamondView.drawingAttribute = ShapeView.DrawingProperty(shape: .diamond)
        squiggleView.drawingAttribute = ShapeView.DrawingProperty(shape: .squiggle)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
