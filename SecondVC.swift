//
//  SecondVC.swift
//  swiftFrame
//
//  Created by MrWu on 2017/12/1.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit


class SecondVC: BaseVC {

    @IBOutlet weak var m_myTable: TableSort!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = [["title":"^?等是?11"],["title":"@啊是"],["title":"$中是"],["title":"^?出是?"], ["title":"(我是"],["title":"*等是"],["title":"[出]是"],["title":"[等]是"],["title":"@#$"],["title":"@$#"],["title":"512出是"],["title":"341出是"],["title":"@#$$出是123:\"^&"]]
        m_myTable.setDataWithOrder(array, title: "title", bOrder: false)
        // Do any additional setup after loading the view.
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
