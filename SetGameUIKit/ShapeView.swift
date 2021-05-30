//
//  CardView.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/30.
//

import UIKit


class OvalView: UIView {
    override func draw(_ rect: CGRect) {
        let oval = UIBezierPath(ovalIn: bounds)
        UIColor.red.setFill()
        oval.fill()
    }
}


class DiamondView: UIView {
    override func draw(_ rect: CGRect) {
        let diamond = UIBezierPath()
        
        let halfX = (bounds.minX + bounds.maxX) / 2
        let halfY = (bounds.minY + bounds.maxY) / 2
        
        diamond.move(to: CGPoint(x: bounds.minX, y: halfY))
        diamond.addLine(to: CGPoint(x: halfX, y: bounds.minY))
        diamond.addLine(to: CGPoint(x: bounds.maxX, y: halfY))
        diamond.addLine(to: CGPoint(x: halfX, y: bounds.maxY))
        diamond.close()
        
        UIColor.red.setFill()
        diamond.fill()
    }
}

class SquiggleView: UIView {
    
    private let spanOfSquiggleRatio: CGFloat = 0.4
    private let controlRatio: CGFloat = 0.5
    
    override func draw(_ rect: CGRect) {
        let squiggle = UIBezierPath()
        let squiggleSpan = bounds.height * spanOfSquiggleRatio
        let squiggleHeight = (bounds.height - squiggleSpan) / 2
        let controlDiff = bounds.width / 4 * controlRatio
        
        squiggle.move(to: .zero)
        squiggle.addQuadCurve(to: CGPoint(x: bounds.width / 4, y: squiggleHeight), controlPoint: CGPoint(x: bounds.width / 4 - controlDiff, y: squiggleHeight))
        squiggle.addQuadCurve(to: CGPoint(x: bounds.width / 2, y: 0), controlPoint: CGPoint(x: bounds.width / 4 + controlDiff, y: squiggleHeight))
        squiggle.addQuadCurve(to: CGPoint(x: bounds.width * 0.75, y: -squiggleHeight), controlPoint: CGPoint(x: bounds.width * 0.75 - controlDiff, y: -squiggleHeight))
        squiggle.addQuadCurve(to: CGPoint(x: bounds.width, y: 0), controlPoint: CGPoint(x: bounds.width * 0.75 + controlDiff, y: -squiggleHeight))
        squiggle.addLine(to: CGPoint(x: bounds.width, y: squiggleSpan))

        squiggle.addQuadCurve(to: CGPoint(x: bounds.width * 0.75, y: squiggleSpan - squiggleHeight), controlPoint: CGPoint(x: bounds.width * 0.75 + controlDiff, y: squiggleSpan - squiggleHeight))
        
        squiggle.addQuadCurve(to: CGPoint(x: bounds.width / 2, y: squiggleSpan), controlPoint: CGPoint(x: bounds.width * 0.75 - controlDiff, y: squiggleSpan - squiggleHeight))
        
        squiggle.addQuadCurve(to: CGPoint(x: bounds.width / 4, y: squiggleSpan + squiggleHeight), controlPoint: CGPoint(x: bounds.width / 4 + controlDiff, y: squiggleSpan + squiggleHeight))
        squiggle.addQuadCurve(to: CGPoint(x: 0, y: squiggleSpan), controlPoint: CGPoint(x: bounds.width / 4 - controlDiff, y: squiggleSpan + squiggleHeight))
        
        squiggle.close()

        
        squiggle.apply(.identity.translatedBy(x: 0, y: 0.5 * bounds.height * (1 - spanOfSquiggleRatio)))
   
        
        UIColor.red.setStroke()
        UIColor.red.setFill()
        squiggle.fill()
    }
}
