//
//  WelcomeVC.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit



class WelcomeVC: BaseVC,UIScrollViewDelegate {
    private let PAGECOUNT = 4
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initScrollView()
    {
        let smodel = UIDevice.DeviceModel();
        let imgiphone5 = "WelcomeImgs.bundle/iphone5-%zd.png"
        let imgiphone6 = "WelcomeImgs.bundle/iphone6-%zd.png"
        let imgiphone6p = "WelcomeImgs.bundle/iphone6plus-%zd.png"
        var imgPath:String
        switch smodel {
        case Model.Iphone5s:
            imgPath = imgiphone5
            break
        case Model.Iphone6:
            imgPath = imgiphone6;
            break
        case Model.Iphone6p:
            imgPath = imgiphone6p
            break
        default:
            imgPath = imgiphone6
        }
        
        for i in 1...PAGECOUNT {
            let imageView = UIImageView(frame: CGRect(x: DEVICE_WIDTH * CGFloat(i - 1), y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT))
            let imageName = String.init(format: imgPath, i)
            let image = UIImage(named: imageName)
            imageView.image = image
            scrollView.addSubview(imageView)
        }
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: CGFloat(PAGECOUNT) * DEVICE_WIDTH, height: DEVICE_HEIGHT)
        scrollView.isPagingEnabled = true;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if (scrollView.contentOffset.x + scrollView.frame.size.width > scrollView.contentSize.width + 40) {
            //向左滑动超出了40像素则进入主页
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainVC")
            scrollView.isUserInteractionEnabled = false;
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
