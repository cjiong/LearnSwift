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
    var pathColor: UIColor = UIColor.blackColor()
    var boardBackgroundColor: UIColor!
    
    var lines = [Line]()
    var touchPoint: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            touchPoint = touch.locationInView(self)
        }
        
        super.touchesBegan(touches, withEvent: event)
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let firstTouch = touches.first {
            
            let endPoint = firstTouch.locationInView(self)
            lines.append(Line(start: touchPoint, end: endPoint))
            touchPoint = endPoint
        }
        
        super.touchesBegan(touches, withEvent: event)
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        
        for line in lines {
            CGContextMoveToPoint(context, line.startPoint.x, line.startPoint.y)
            CGContextAddLineToPoint(context, line.endPoint.x, line.endPoint.y)
        }
        
        CGContextSetStrokeColorWithColor(context, pathColor.CGColor)
        CGContextSetLineWidth(context, lineWidth)
        CGContextStrokePath(context)

    }
    
    //MARK: 保存图片
    func getImage() -> UIImage {
        
        UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width,
            self.bounds.size.height))
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    //MARK: 清空画板
    func clearBoard() {
        
        self.lines = []
        self.setNeedsDisplay()
    }
    
}
