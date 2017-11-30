//
//  MyScrollView.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/29.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable
class MyScrollView: UIView,UIScrollViewDelegate {
    private let idratio = "subheight"
    @IBOutlet weak var m_scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var bneedAuto = true
    var bneedPageControll = true
    var bScollable = true
    var m_timer:Timer?
//    var m_dataArray:Array<Dictionary<String,Any>>?
    var m_dataArray:Array<Any>?
    var imgCount:Int = 0
    var m_eventTarget:BaseVC?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp()
    {
        let viewtop:UIView = Bundle.main.loadNibNamed("MyScrollView", owner: self, options: nil)?.first as! UIView
        viewtop.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(viewtop)
    }
    
    deinit {
        m_timer?.invalidate()
        m_timer = nil
        D_DEBUG(message: "MyScrollView delloc")
    }
    
    
    func UpdateScrollView(eventTarget:BaseVC,dataarray:Array<String>?)
    {
        if dataarray?.count == 0 {
            return;
        }
        
        //如果当前滚动视图内有内容则清空
        if m_dataArray != nil {
            m_dataArray?.removeAll()
            let views = m_scrollView.subviews;
            _ = views.map{
                $0.removeFromSuperview()
            }
        }
        
        m_dataArray = dataarray
        let rc = m_scrollView.bounds;
        m_scrollView.contentSize = CGSize(width: rc.size.width * CGFloat(((m_dataArray?.count)!) + 2), height: rc.size.height)
        if m_dataArray?.count == 1 {//只有1张图 不滚动
            let bt = UIButton(type: UIButtonType.custom)
            bt.frame = CGRect(x: 0, y: 0, width: rc.size.width, height: rc.size.height)
            var strUrl = m_dataArray![0] as! String
            strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!
            let imgUrl = URL(string: strUrl)
            //            let imgView:UIImageView = UIImageView()
            //            imgView.contentMode = UIViewContentMode.scaleToFill
            //            imgView.kf.setImage(with: imgUrl)
            //            bt.addSubview(imgView)
            bt.kf.setBackgroundImage(with: imgUrl, for: UIControlState.normal)
            
            //是否响应点击事件,这里我们刚改为swift 先注释掉
            /*
             var ntype = m_dataArray![0]["type"] as! NSNumber
             if(ntype.intValue == 5)
             {
             bt.addTarget(self, action: #selector(scrollClick(sender:)), for: UIControlEvents.touchUpInside)
             }
             */
            bt.tag = 0
            m_scrollView.addSubview(bt)
            m_scrollView.isScrollEnabled = false
            pageControl.isHidden = true
            imgCount = (m_dataArray?.count)!
            m_scrollView.contentSize = CGSize(width: rc.size.width, height: rc.size.height)
            m_eventTarget = eventTarget
            return
        }
        else
        {
            imgCount = (m_dataArray?.count)!
            //因为要循环滚动,所以多2张图片
            for i in 0..<(imgCount + 2)
            {
                let bt = UIButton(type:UIButtonType.custom)
                bt.frame = CGRect(x: rc.size.width * CGFloat(i), y: 0, width: rc.size.width, height: rc.size.height)
                var strUrl:String = ""
                if(i == 0)//滚动视图最左边一张view,实际是最后放入的view
                {
                    strUrl = m_dataArray?.last! as! String
                    bt.tag = (m_dataArray?.count)! - 1;
                }
                else if (i == (m_dataArray?.count)! + 1)//滚动视图最右边一张view,实际是最早放入的view
                {
                    strUrl = m_dataArray?.first! as! String
                    bt.tag = 0
                }
                else
                {
                    strUrl = m_dataArray?[i - 1] as! String
                    bt.tag = i - 1
                }
                
                strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!
                let imgUrl = URL(string: strUrl)
                //            let imgView:UIImageView = UIImageView()
                //            imgView.contentMode = UIViewContentMode.scaleToFill
                //            imgView.kf.setImage(with: imgUrl)
                //            bt.addSubview(imgView)
                bt.kf.setBackgroundImage(with: imgUrl, for: UIControlState.normal)
                
                //是否响应点击事件,这里我们刚改为swift 先注释掉
                /*
                 var ntype = m_dataArray![0]["type"] as! NSNumber
                 if(ntype.intValue == 5)
                 {
                 bt.addTarget(self, action: #selector(scrollClick(sender:)), for: UIControlEvents.touchUpInside)
                 }
                 */
                m_scrollView.addSubview(bt)
            }
            
            //// 为什么不用bringSubviewToFront,发现xib嵌入进storyboard中或则多个xib相嵌入时,层级关系容易弄混
            // 如果没找到正确的view,就调用[正确的view bringSubviewToFront:_pagecontrol],则不会生效。
            // 因此用先remove,再add的方式出现在最顶层.
            //    [self bringSubviewToFront:_pagecontrol];
            //将pageControl置顶
            pageControl.isHidden = false
            pageControl.numberOfPages = (m_dataArray?.count)!
            pageControl.currentPage = 0
            m_scrollView.isScrollEnabled = true
            m_scrollView.bounces = false
            m_eventTarget = eventTarget
            m_eventTarget?.view.bringSubview(toFront: pageControl)
//            pageControl.removeFromSuperview()
//            self.addSubview(pageControl)
        }
        
        bneedAuto = true
        if(bneedAuto)
        {
            self.beginAutoScroll()
        }
        
    }
    
    //自适应高度
    func UpdateScrollView(eventTarget:BaseVC,dataarray:Array<Dictionary<String,Any>>?,index:Int,bflag:Bool)
    {
        if dataarray?.count == 0 {
            return;
        }
        
        //如果当前滚动视图内有内容则清空
        if (m_dataArray?.count)! > 0 {
            m_dataArray?.removeAll()
            let views = m_scrollView.subviews;
            _ = views.map{
                $0.removeFromSuperview()
                }
        }
        
        //根据服务器发过来的长宽计算出需要改变的高度
        var width:NSNumber? = nil
        var height:NSNumber? = nil
        var subheight:CGFloat = 0.0
        for ptmp in self.constraints {
            if ptmp.identifier == idratio {
                width = dataarray?[index]["sizeW"] as? NSNumber
                height = dataarray?[index]["sizeH"] as? NSNumber
                let rct = self.frame
                let needhight = rct.size.width / CGFloat((width?.floatValue)!) * CGFloat((height?.floatValue)!)
                subheight = needhight - self.frame.size.height
                ptmp.constant += subheight
                break
            }
        }
        
        //构建pagecontroll
        /*
        if (_pagecontrol == nil) {
            UIPageControl *page = [[UIPageControl alloc] init];
            CGRect rcpage = _scrollView.frame;
            rcpage.origin.y = rcpage.size.height - 20 + subheight;
            rcpage.size.height = 10;
            [page setFrame:rcpage];
            [self addSubview:page];
            _pagecontrol = page;
            [_pagecontrol setCurrentPage:dataarray.count];
            [_pagecontrol setTintColor:[UIColor lightGrayColor]];
            [_pagecontrol setCurrentPageIndicatorTintColor:[UIColor redColor]];
        }
 */
        //字典里"adList"保存的是图片链接的数组
        m_dataArray = dataarray?[index]["adList"] as? Array<Dictionary<String, Any>>
        let rc = m_scrollView.bounds;
        m_scrollView.contentSize = CGSize(width: rc.size.width * CGFloat(((m_dataArray?.count)!) + 2), height: rc.size.height)
        if m_dataArray?.count == 1 {//只有1张图 不滚动
            let bt = UIButton(type: UIButtonType.custom)
            bt.frame = CGRect(x: 0, y: 0, width: rc.size.width, height: rc.size.height)
            var strDic = m_dataArray![0] as! Dictionary<String,String>
            var strUrl = strDic["src"]!
//            var strUrl = m_dataArray![0]["src"] as! String
            strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!
            let imgUrl = URL(string: strUrl)
//            let imgView:UIImageView = UIImageView()
//            imgView.contentMode = UIViewContentMode.scaleToFill
//            imgView.kf.setImage(with: imgUrl)
//            bt.addSubview(imgView)
            bt.kf.setBackgroundImage(with: imgUrl, for: UIControlState.normal)
            
            //是否响应点击事件,这里我们刚改为swift 先注释掉
            /*
            var ntype = m_dataArray![0]["type"] as! NSNumber
            if(ntype.intValue == 5)
            {
                bt.addTarget(self, action: #selector(scrollClick(sender:)), for: UIControlEvents.touchUpInside)
            }
            */
            bt.tag = 0
            m_scrollView.addSubview(bt)
            m_scrollView.isScrollEnabled = false
            pageControl.isHidden = true
            imgCount = (m_dataArray?.count)!
            m_scrollView.contentSize = CGSize(width: rc.size.width, height: rc.size.height)
            m_eventTarget = eventTarget
            return
        }
        else
        {
            imgCount = (m_dataArray?.count)!
            //因为要循环滚动,所以多2张图片
            for i in 0..<(imgCount + 2)
            {
                let bt = UIButton(type:UIButtonType.custom)
                bt.frame = CGRect(x: rc.size.width * CGFloat(i), y: 0, width: rc.size.width, height: rc.size.height)
                var strUrl:String = ""
                if(i == 0)//滚动视图最左边一张view,实际是最后放入的view
                {
                    var strDic = m_dataArray?.last as! Dictionary<String,String>
                    strUrl = strDic["src"]!
//                    strUrl = m_dataArray?.last!["src"] as! String
                    bt.tag = (m_dataArray?.count)! - 1;
                }
                else if (i == (m_dataArray?.count)! + 1)//滚动视图最右边一张view,实际是最早放入的view
                {
                    var strDic = m_dataArray?.first as! Dictionary<String,String>
                    strUrl = strDic["src"]!
//                    strUrl = m_dataArray?.first!["src"] as! String
                    bt.tag = 0
                }
                else
                {
                    var strDic = m_dataArray?[i - 1] as! Dictionary<String,String>
                    strUrl = strDic["src"]!
//                    strUrl = m_dataArray?[i - 1]["src"] as! String
                    bt.tag = i - 1
                }
                
                strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)!
                let imgUrl = URL(string: strUrl)
                //            let imgView:UIImageView = UIImageView()
                //            imgView.contentMode = UIViewContentMode.scaleToFill
                //            imgView.kf.setImage(with: imgUrl)
                //            bt.addSubview(imgView)
                bt.kf.setBackgroundImage(with: imgUrl, for: UIControlState.normal)
                
                //是否响应点击事件,这里我们刚改为swift 先注释掉
                /*
                 var ntype = m_dataArray![0]["type"] as! NSNumber
                 if(ntype.intValue == 5)
                 {
                 bt.addTarget(self, action: #selector(scrollClick(sender:)), for: UIControlEvents.touchUpInside)
                 }
                 */
                m_scrollView.addSubview(bt)
                
            }
            
            //// 为什么不用bringSubviewToFront,发现xib嵌入进storyboard中或则多个xib相嵌入时,层级关系容易弄混
            // 如果没找到正确的view,就调用[正确的view bringSubviewToFront:_pagecontrol],则不会生效。
            // 因此用先remove,再add的方式出现在最顶层.
            //    [self bringSubviewToFront:_pagecontrol];
            //将pageControl置顶
            pageControl.isHidden = false
            pageControl.numberOfPages = (m_dataArray?.count)!
            pageControl.currentPage = 0
            m_scrollView.isScrollEnabled = true
            m_scrollView.bounces = false
            m_eventTarget = eventTarget
            pageControl.removeFromSuperview()
            self.addSubview(pageControl)
        }
        
        bneedAuto = bflag
        if(bneedAuto)
        {
            self.beginAutoScroll()
        }
    }
    
    func beginAutoScroll()
    {
        m_timer?.invalidate()
        m_timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(Ontimer(timer:)), userInfo: nil, repeats: true)
    }
    
    func Ontimer(timer:Timer)
    {
        UIView.animate(withDuration: 0.5, animations: {
            var point = self.m_scrollView.contentOffset
            point.x += self.m_scrollView.bounds.size.width
            self.m_scrollView.contentOffset = point
            self.pageControl.currentPage = Int(point.x / self.m_scrollView.bounds.size.width)
        }) { (completion) in
            var point = self.m_scrollView.contentOffset
            if(point.x >= self.m_scrollView.bounds.size.width * CGFloat(self.imgCount + 1))
            {
                point.x = self.m_scrollView.bounds.size.width
            }
            self.pageControl.currentPage = Int(point.x / self.m_scrollView.bounds.size.width - 1)
            self.m_scrollView.contentOffset = point
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func scrollClick(sender:UIButton)
    {
        
    }
}
