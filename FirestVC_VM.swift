//
//  FirestVC_VM.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import MBProgressHUD
import RxSwift

class FirstVC_VM {
    var dataModel:BannerModel
    init(){
        dataModel = BannerModel()
    }
    
    //常规写法，可通过数据绑定通知视图更新
    func GetBanner()
    {
        let strAdd = ApiHelper.getApiAddress(api: API_BANNER_HOME)
        NetManager<BannerModel>.request(url: strAdd, method: .get, parameters: nil)
        {
            [weak self](bsucess, strError, reData) in
            if bsucess
            {
                self?.dataModel = reData as! BannerModel
            }
        }
    }
    
    //函数式写法
    func Rx_GetBanner() ->Single<Bool>
    {
        return Single<Bool>.create(subscribe: { (single) -> Disposable in
            let strAdd = ApiHelper.getApiAddress(api: API_BANNER_HOME)
            
            NetManager<BannerModel>.request(url: strAdd, method: .get, parameters: nil)
            {
                [weak self](bsucess, strError, reData) in
                if bsucess
                {
                    self?.dataModel = reData as! BannerModel
                    single(.success(true))
                }
            }
            return Disposables.create()
        })
    }
    
    func Rx_GetBannerImgUrls() ->Single<Array<String>>
    {
        return Single<Array<String>>.create(subscribe: { [weak self](single) -> Disposable in
            if (self?.dataModel.t?.count)! > 0
            {
                var imgarray = Array<String>()
                for tmp in (self?.dataModel.t)!
                {
                    imgarray.append(tmp.carImgurl!)
                }
                single(.success(imgarray))
            }
            return Disposables.create()
        })
    }
}
