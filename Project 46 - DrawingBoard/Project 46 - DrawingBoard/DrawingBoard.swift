//
//  DrawingBoard.swift
//  Project 46 - DrawingBoard
//
//  Created by 陈炯 on 16/8/15.
//  Copyright © 2016年 Jiong. All rights reserved.
//

import UIKit

class DrawingBoard: UIView {

    var lineWidth: CGFloat = 2
    var pathColor: UIColor = UIColor.black
    var boardBackgroundColor: UIColor!
    
    //MARK: 保存线条
    var lines = [Line]()
    var touchPoint: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            touchPoint = touch.location(in: self)
        }
        
        super.touchesBegan(touches, with: event)
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            
            let endPoint = firstTouch.location(in: self)
            lines.append(Line(start: touchPoint, end: endPoint))
            touchPoint = endPoint
        }
        
        super.touchesBegan(touches, with: event)
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        
        for line in lines {
            context?.move(to: CGPoint(x: line.startPoint.x, y: line.startPoint.y))
            context?.addLine(to: CGPoint(x: line.endPoint.x, y: line.endPoint.y))
        }
        
        context?.setStrokeColor(pathColor.cgColor)
        context?.setLineWidth(lineWidth)
        context?.strokePath()

    }
    
    //MARK: 保存图片
    func getImage() -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width,
            height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    //MARK: 清空画板
    func clearBoard() {
        
        self.lines = []
        self.setNeedsDisplay()
    }
    
}
