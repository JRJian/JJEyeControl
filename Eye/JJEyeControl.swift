//
//  JJEyeControl.swift
//  Eye
//
//  Created by chenjiantao on 16/2/17.
//  Copyright © 2016年 chenjiantao. All rights reserved.
//

import UIKit

class JJEyeControl: UIView {
    
    // 第一道反光
    private var eyeFirstLightLayer  : CAShapeLayer = CAShapeLayer()
    
    // 第二道反光
    private var eyeSecondLightLayer : CAShapeLayer = CAShapeLayer()
    
    // 眼球
    private var eyeballLayer        : CAShapeLayer = CAShapeLayer()
    
    // 上眼睑
    private var topEyelidLayer      : CAShapeLayer = CAShapeLayer()
    
    // 下眼睑
    private var bottomEyelidLayer   : CAShapeLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up views
        self.setupSubViews()
    }
    
    required internal init() {
        super.init(frame: CGRectZero)
        
        // Set up views
        self.setupSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    class func centerPoint(frame: CGRect) -> CGPoint {
        return CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2)
    }
    
    class func degreeToRadian(degree: Double) -> Double {
        return (degree / 180.0) * M_PI
    }
    
    private func setupSubViews() {
        self.layer.addSublayer(eyeFirstLightLayer)
        self.layer.addSublayer(eyeSecondLightLayer)
        self.layer.addSublayer(eyeballLayer)
        self.layer.addSublayer(topEyelidLayer)
        self.layer.addSublayer(bottomEyelidLayer)
        
        let centerPoint = JJEyeControl.centerPoint(self.bounds)
        var path: UIBezierPath = UIBezierPath(arcCenter: JJEyeControl.centerPoint(self.bounds),
            radius: CGRectGetWidth(self.bounds) * 0.2,
            startAngle: CGFloat(JJEyeControl.degreeToRadian(230.0)),
            endAngle: CGFloat(JJEyeControl.degreeToRadian(265.0)),
            clockwise: true)
        eyeFirstLightLayer.borderColor = UIColor.blackColor().CGColor
        eyeFirstLightLayer.lineWidth   = 5.0
        eyeFirstLightLayer.path        = path.CGPath
        eyeFirstLightLayer.fillColor   = UIColor.clearColor().CGColor
        eyeFirstLightLayer.strokeColor = UIColor.whiteColor().CGColor
        
        path = UIBezierPath(arcCenter: centerPoint,
            radius: CGRectGetWidth(self.bounds) * 0.2,
            startAngle: CGFloat(JJEyeControl.degreeToRadian(211.0)),
            endAngle: CGFloat(JJEyeControl.degreeToRadian(220.0)),
            clockwise: true)
        eyeSecondLightLayer.borderColor = UIColor.blackColor().CGColor
        eyeSecondLightLayer.lineWidth   = 5.0
        eyeSecondLightLayer.path        = path.CGPath
        eyeSecondLightLayer.fillColor   = UIColor.clearColor().CGColor
        eyeSecondLightLayer.strokeColor = UIColor.whiteColor().CGColor
        
        path = UIBezierPath(arcCenter: centerPoint,
            radius: CGRectGetWidth(self.bounds) * 0.3,
            startAngle: CGFloat(JJEyeControl.degreeToRadian(0.0)),
            endAngle: CGFloat(JJEyeControl.degreeToRadian(360.0)),
            clockwise: true)
        eyeballLayer.borderColor = UIColor.blackColor().CGColor
        eyeballLayer.lineWidth   = 1.0
        eyeballLayer.path        = path.CGPath
        eyeballLayer.fillColor   = UIColor.clearColor().CGColor
        eyeballLayer.strokeColor = UIColor.whiteColor().CGColor
        eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5)
        
        path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, CGRectGetHeight(self.bounds) / 2))
        path.addQuadCurveToPoint(CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2), controlPoint: CGPointMake(CGRectGetWidth(self.bounds) / 2, centerPoint.y - centerPoint.y - 20))
        topEyelidLayer.borderColor  = UIColor.blackColor().CGColor
        topEyelidLayer.lineWidth    = 1.0
        topEyelidLayer.path         = path.CGPath
        topEyelidLayer.fillColor    = UIColor.clearColor().CGColor
        topEyelidLayer.strokeColor  = UIColor.whiteColor().CGColor
        
        path = UIBezierPath()
        path.moveToPoint(CGPointMake(0, CGRectGetHeight(self.bounds) / 2))
        path.addQuadCurveToPoint(CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2),
            controlPoint :CGPointMake(CGRectGetWidth(self.frame) / 2, centerPoint.y + centerPoint.y + 20))
        bottomEyelidLayer.borderColor  = UIColor.blackColor().CGColor
        bottomEyelidLayer.lineWidth    = 1.0
        bottomEyelidLayer.path         = path.CGPath
        bottomEyelidLayer.fillColor    = UIColor.clearColor().CGColor
        bottomEyelidLayer.strokeColor  = UIColor.whiteColor().CGColor
        
        // Default
        eyeFirstLightLayer.lineWidth    = 0
        eyeSecondLightLayer.lineWidth   = 0
        eyeballLayer.opacity            = 0
        topEyelidLayer.strokeStart      = 0.5
        topEyelidLayer.strokeEnd        = 0.5
        bottomEyelidLayer.strokeStart   = 0.5
        bottomEyelidLayer.strokeEnd     = 0.5
    }
    
    internal func animation(offsetY: CGFloat) {
        let flag: CGFloat = self.frame.origin.y * 2.0 - 20.0;
        if offsetY < flag {
            if (self.eyeFirstLightLayer.lineWidth < 5.0) {
                self.eyeFirstLightLayer.lineWidth += 1.0;
                self.eyeSecondLightLayer.lineWidth += 1.0;
            }
        }
        
        if offsetY < flag - 20 {
            if (self.eyeballLayer.opacity <= 1.0) {
                self.eyeballLayer.opacity += 0.1;
            }
            
        }
        
        if offsetY < flag - 40 {
            if  self.topEyelidLayer.strokeEnd < 1.0 && self.topEyelidLayer.strokeStart > 0.0 {
                self.topEyelidLayer.strokeEnd       += 0.1;
                self.topEyelidLayer.strokeStart     -= 0.1;
                self.bottomEyelidLayer.strokeEnd    += 0.1;
                self.bottomEyelidLayer.strokeStart  -= 0.1;
            }
        }
        
        if offsetY > flag - 40 {
            if  self.topEyelidLayer.strokeEnd > 0.5 && self.topEyelidLayer.strokeStart < 0.5 {
                self.topEyelidLayer.strokeEnd       -= 0.1;
                self.topEyelidLayer.strokeStart     += 0.1;
                self.bottomEyelidLayer.strokeEnd    -= 0.1;
                self.bottomEyelidLayer.strokeStart  += 0.1;
            }
        }
        
        if offsetY > flag - 20 {
            if  self.eyeballLayer.opacity >= 0.0 {
                self.eyeballLayer.opacity -= 0.1;
            }
        }
        
        if offsetY > flag {
            if  self.eyeFirstLightLayer.lineWidth > 0.0 {
                self.eyeFirstLightLayer.lineWidth   -= 1.0;
                self.eyeSecondLightLayer.lineWidth  -= 1.0;
            }
        }
    }
}
