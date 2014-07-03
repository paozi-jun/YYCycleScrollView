

import UIKit

class YYCycleScrollView: UIView {

    var totalPagesCount:()->Int = {()->Int in
        return 0
    }
    
    var fetchContentViewAtIndex:()->UIView = {()->UIView in
        return UIView()
    }
    
    var TapActionBlock:(pageIndex:Int)->() = {(pageIndex:Int)->() in}
    
    var scrollView:UIScrollView?{
    return UIScrollView()
    }
    
    init(frame:CGRect,animationDuration:NSTimeInterval){
        super.init(frame: frame)
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }

    //
    //  YYCycleScrollView.swift
    //  YYCycleScrollView
    //
    //  Created by 向文品 on 14-7-3.
    //  Copyright (c) 2014年 向文品. All rights reserved.
    //

}
