

import UIKit

class MainViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var viewsArray = NSMutableArray()
        var colorArray = [UIColor.cyanColor(),UIColor.blueColor(),UIColor.greenColor(),UIColor.yellowColor(),UIColor.purpleColor()]
        for  i in 0..5 {
            var tempImgaeView = UIImageView(frame:CGRectMake(0, 0, 320, 300))
            tempImgaeView.image = UIImage(named:"\(i).jpeg")
            tempImgaeView.contentMode = UIViewContentMode.ScaleAspectFill
            tempImgaeView.clipsToBounds = true
            viewsArray.addObject(tempImgaeView)
        }
        
        var mainScorllView = YYCycleScrollView(frame:CGRectMake(0, 100, 320, 300),animationDuration:2.0)
        //mainScorllView.backgroundColor = UIColor.purpleColor()
        mainScorllView.fetchContentViewAtIndex = {(pageIndex:Int)->UIView in
            return viewsArray.objectAtIndex(pageIndex) as UIView
        }

        mainScorllView.totalPagesCount = {()->Int in
            return 5;
        }
        mainScorllView.TapActionBlock = {(pageIndex:Int)->() in
            println("点击了\(pageIndex)")
        }
        self.view.addSubview(mainScorllView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
