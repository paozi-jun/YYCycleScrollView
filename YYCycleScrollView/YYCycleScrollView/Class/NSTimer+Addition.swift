

import Foundation

extension NSTimer {
    
    func pauseTimer(){
        if !self.valid{
            return
        }
        self.fireDate = NSDate.distantFuture() as NSDate
    }
    
    func resumeTimer(){
        if !self.valid{
            return
        }
        self.fireDate = NSDate()
    }
    
    func resumeTimerAfterTimeInterval(interval:NSTimeInterval){
        if !self.valid{
            return
        }
        self.fireDate = NSDate(timeIntervalSinceNow:interval)
    }
}