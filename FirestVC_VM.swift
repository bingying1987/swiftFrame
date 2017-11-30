//
//  FirestVC_VM.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import MBProgressHUD
class FirstVC_VM {
    var dataModel:BannerModel
    init(){
        dataModel = BannerModel()
    }
    
    func GetBanner()
    {
        let strAdd = ApiHelper.getApiAddress(api: API_BANNER_HOME)
        MBProgressHUD.showMessage(message: "正在加载...")
        NetManager<BannerModel>.request(url: strAdd, method: .get, parameters: nil)
        {
            (bsucess, strError, reData) in
            MBProgressHUD.hideHUD()
            if bsucess
            {
                self.dataModel = reData as! BannerModel
            }
            else
            {
                MBProgressHUD.showError(error: strError)
            }
        }
    }
}
