//
//  CardView.swift
//  SetGameUIKit
//
//  Created by Hui Chih Wang on 2021/5/30.
//

import UIKit

class ShapeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentMode = .redraw
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var drawingAttribute = DrawingProperty() {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawingAttribute.color.setStroke()
        drawingAttribute.color.setFill()
        
        let shape = createShape()
        
        if drawingAttribute.shading == .stripe {
            let stripe = createStripePattern()
            stripe.stroke()
        }
        
        shape.lineWidth = 10
        shape.stroke()
        
        if drawingAttribute.shading == .solid {
            shape.fill()
        }
    }
    
    struct DrawingProperty {
        var shape = Shape.oval
        var shading: Shading = .stripe
        var color: UIColor = .green
    }
    
    enum Shape {
        case oval
        case diamond
        case squiggle
    }
    
    enum Shading {
        case solid
        case stroke
        case stripe
    }
    
}

extension ShapeView {
    private func createShape() -> UIBezierPath {
        let shapePath: UIBezierPath
        
        switch drawingAttribute.shape {
        case .oval:
            shapePath = createOvalShape()
        case .diamond:
            shapePath = createDiamondShape()
        case .squiggle:
            shapePath = createSquiggleShape()
        }
        shapePath.addClip()
        return shapePath
    }
    
    private func createOvalShape() -> UIBezierPath {
        return UIBezierPath(ovalIn: bounds)
    }
    
    private func createDiamondShape() -> UIBezierPath {
        let diamond = UIBezierPath()
        
        let halfX = (bounds.minX + bounds.maxX) / 2
        let halfY = (bounds.minY + bounds.maxY) / 2
        
        diamond.move(to: CGPoint(x: bounds.minX, y: halfY))
        diamond.addLine(to: CGPoint(x: halfX, y: bounds.minY))
        diamond.addLine(to: CGPoint(x: bounds.maxX, y: halfY))
        diamond.addLine(to: CGPoint(x: halfX, y: bounds.maxY))
        diamond.close()
        
        return diamond
    }
    
    private func createStripePattern() -> UIBezierPath {
        let stridWidthNumber = 20
        
        let stripePattern = UIBezierPath()
        stride(from: bounds.minX, to: bounds.maxX, by: bounds.width / CGFloat(stridWidthNumber)).forEach { startX in
            stripePattern.move(to: CGPoint(x: startX, y: 0))
            stripePattern.addLine(to: CGPoint(x: startX, y: bounds.maxY))
        }
        
        return stripePattern
    }
    
    private func createSquiggleShape() ->UIBezierPath {
        let spanOfSquiggleRatio: CGFloat = 0.4
        let controlRatio: CGFloat = 0.5
        
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
        
        return squiggle
    }
}

