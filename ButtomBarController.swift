//
//  ButtomBarController.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ButtomBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITabBar.appearance().tintColor = UIColor.colorWithHexRGB(RGB: 0xec594f)
        let titleattrs = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:APP_FONT(fontName: APP_FONT_NAME_BOLD, fontSize: 18.0)]
        let controllers = self.childViewControllers;
        for ctr in controllers {
            let tmp = ctr as? UINavigationController
            tmp?.navigationBar.titleTextAttributes = titleattrs;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
