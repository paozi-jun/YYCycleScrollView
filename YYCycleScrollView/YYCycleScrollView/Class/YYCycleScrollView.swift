

import UIKit

class YYCycleScrollView: UIView,UIScrollViewDelegate {

    var _totalPagesCount:(()->Int)!
    var totalPagesCount:(()->Int)!{
    set{
        self._totalPagesCount = newValue
        self.totalPageCount = _totalPagesCount()
    }
    get{
        return self._totalPagesCount
    }
    }
    
    var fetchContentViewAtIndex:((Int)->UIView)!
    
    var TapActionBlock:((pageIndex:Int)->())!
    
    var currentPageIndex:Int!
    
    var totalPageCount:Int!
    var contentViews:NSMutableArray!
    var animationTimer:NSTimer!
    var animationDuration:NSTimeInterval!
    
    var scrollView:UIScrollView!
    
    init(frame:CGRect,animationDuration:NSTimeInterval){
        super.init(frame: frame)
        if animationDuration>0.0 {
            self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(self.animationDuration, target: self, selector: "animationTimerDidFired:", userInfo: nil, repeats: true)
            self.animationTimer.pauseTimer()
        }
        
        self.autoresizesSubviews = true
        self.scrollView = UIScrollView(frame:self.bounds)
        //self.scrollView.autoresizingMask = 0xFF
        self.scrollView.contentMode = UIViewContentMode.Center
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0)
        self.scrollView.pagingEnabled = true
        self.addSubview(self.scrollView)
        self.currentPageIndex = 0
    }
    
    init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }

    func configContentViews(){
        for view:AnyObject in self.scrollView.subviews{
            (view  as UIView).removeFromSuperview()
        }
        self.setScrollViewContentDataSource()
        var counter:Int = 0
        for i in 0..self.contentViews.count{
            var contentView = self.contentViews.objectAtIndex(i) as UIView
            contentView.userInteractionEnabled = true
            var tapGesture = UITapGestureRecognizer(target:self,action:"contentViewTapAction:")
            contentView.addGestureRecognizer(tapGesture)
            var rightRect = contentView.frame;
            rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * Float(i), 0)
            contentView.frame = rightRect
            self.scrollView.addSubview(contentView)
        }
        self.scrollView.setContentOffset(CGPointMake(self.scrollView.frame.size.width,0), animated: false)
    }
    
    func setScrollViewContentDataSource(){
        var previousPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex - 1)
        var rearPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex + 1)
        if self.contentViews == nil {
            self.contentViews = NSMutableArray()
        }
        self.contentViews.removeAllObjects()
        
        if self.fetchContentViewAtIndex {
            self.contentViews.addObject(self.fetchContentViewAtIndex(previousPageIndex))
            self.contentViews.addObject(self.fetchContentViewAtIndex(self.currentPageIndex))
            self.contentViews.addObject(self.fetchContentViewAtIndex(rearPageIndex))
        }
    }
    
    func getValidNextPageIndexWithPageIndex(currentPageIndex:Int)->Int{
        if currentPageIndex == -1{
            return self.totalPageCount - 1
        }else if currentPageIndex == self.totalPageCount{
            return 0
        }else {
            return currentPageIndex
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!){
        self.animationTimer.pauseTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool){
        self.animationTimer.resumeTimerAfterTimeInterval(self.animationDuration)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!){
        var contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX >= 2.0 * CGRectGetWidth(scrollView.frame) {
            self.currentPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex + 1)
            self.configContentViews()
        }
        if contentOffsetX <= 0 {
            self.currentPageIndex = self.getValidNextPageIndexWithPageIndex(self.currentPageIndex - 1)
            self.configContentViews()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!){
        scrollView.setContentOffset(CGPointMake(CGRectGetWidth(scrollView.frame), 0),animated:true)
    }
    
    
    func animationTimerDidFired(timer:NSTimer){
        var newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y)
        self.scrollView.setContentOffset(newOffset,animated:true)
    }
    
    func contentViewTapAction(tap:UITapGestureRecognizer){
        if self.TapActionBlock{
            self.TapActionBlock(pageIndex: self.currentPageIndex)
        }
    }
}

