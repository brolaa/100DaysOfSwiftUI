//
//  Arrow.swift
//  Drawing
//
//  Created by Bartosz Rola on 21/02/2023.
//

import Foundation
import SwiftUI

struct Arrow: InsettableShape {
    var insetAmount = 0.0
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func topTriangleInsetAmount(rect: CGRect) -> CGFloat {
        let b = CGPointDistance(from: CGPoint(x: rect.minX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.minY))
        let a = CGPointDistance(from: CGPoint(x: rect.minX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.midY))
        
        return (b*insetAmount)/a
    }
    
    func sideTriangleInsetAmount(rect: CGRect) -> CGFloat {
        let h = CGPointDistance(from: CGPoint(x: rect.midX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.minY))
        let a = CGPointDistance(from: CGPoint(x: rect.minX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.midY))
        let b = CGPointDistance(from: CGPoint(x: rect.minX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.minY))
        
        let m = (a*h)/(a+b)
        
        return (a*insetAmount)/(m)
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY+topTriangleInsetAmount(rect: rect)))
        path.addLine(to: CGPoint(x: rect.minX+sideTriangleInsetAmount(rect: rect), y: rect.midY-insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX/3+insetAmount, y: rect.midY-insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX/3+insetAmount, y: rect.maxY-insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX/3*2-insetAmount, y: rect.maxY-insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX/3*2-insetAmount, y: rect.midY-insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX-sideTriangleInsetAmount(rect: rect), y: rect.midY-insetAmount))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY+topTriangleInsetAmount(rect: rect)))
        path.closeSubpath()
        
        return path
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

/*
 func sideTriangleInsetAmount(rect: CGRect) -> CGFloat {
     let h = CGPointDistance(from: CGPoint(x: rect.midX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.minY))
     let a = CGPointDistance(from: CGPoint(x: rect.minX, y: rect.midY), to: CGPoint(x: rect.midX, y: rect.midY))
     
     return (h*insetAmount)/a
 }
 */
