//
//  ViewController.swift
//  Eye
//
//  Created by chenjiantao on 16/2/17.
//  Copyright © 2016年 chenjiantao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var refresh: JJEyeControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scroll: UIScrollView = UIScrollView(frame: self.view.bounds)
        scroll.backgroundColor = UIColor.blackColor()
        scroll.delegate = self
        scroll.contentSize = CGSizeMake(1, 1000)
        self.view.addSubview(scroll)
        
        var frame: CGRect = self.view.bounds
        frame.size.height = 44
        frame.size.width  = 64
        frame.origin.x    = (CGRectGetWidth(self.view.bounds) - 64) * 0.5
        let refresh: JJEyeControl = JJEyeControl(frame: frame)
        scroll.addSubview(refresh)
        self.refresh = refresh
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.refresh.animation(scrollView.contentOffset.y)
    }
}

