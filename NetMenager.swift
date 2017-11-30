//
//  NetMenager.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import Alamofire
import MBProgressHUD
import HandyJSON


let NET_LOADING_DEFAULT = "正在请求中..."
let NET_RESULT_FAIL = "请求失败,服务器繁忙。"
let NET_DATA_ERROR = "解析数据失败。"

typealias completedBlock = (Bool,String,Any?)->()

class BaseModel:  HandyJSON{
    var state:Int?
    var result:Dictionary<String,Any>?
    var message:String?
    var type:Int?
    var extral:String?
    required init(){}
}



class NetManager<Model:HandyJSON>
{
    static func request(url:URLConvertible,method:HTTPMethod,parameters:Parameters?,complete:@escaping completedBlock)
    {
        request(url: url, method: method, parameters: parameters, encoding: JSONEncoding.default, header: [:], bHud:true,complete: complete)
    }
    
    static func request(url:URLConvertible,method:HTTPMethod,parameters:Parameters?,encoding:ParameterEncoding,header:HTTPHeaders,bHud:Bool,complete:@escaping completedBlock)
    {
        if bHud
        {
            MBProgressHUD.showMessage(message: NET_LOADING_DEFAULT)
        }
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: header).responseJSON { (response) in
            if bHud
            {
                MBProgressHUD.hideHUD()
            }
            
            if(response.result.isSuccess)
            {
                //请求成功
                if let responseModel = BaseModel.deserialize(from: response.result.value as? Dictionary)
                {
                    //这里可以根据BaseModel做一些通用处理
                    if responseModel.state == 1
                    {
                        if bHud
                        {
                            MBProgressHUD.showError(error: responseModel.message!)
                        }
                        complete(false,"",nil)
                        return;
                    }
                    
                    if let resultModel = Model.deserialize(from: responseModel.result)
                    {
                        
                        complete(true,"",resultModel)
                    }
                    else
                    {
                        if bHud
                        {
                            MBProgressHUD.showError(error: NET_DATA_ERROR)
                        }
                        complete(false,"",nil)
                    }
                    
                }
                else
                {
                    if bHud
                    {
                        MBProgressHUD.showError(error: NET_DATA_ERROR)
                    }
                    complete(false, "", nil)
                }
            }
            else
            {
                if bHud
                {
                    MBProgressHUD.showError(error: NET_RESULT_FAIL)
                }
                //请求失败
                complete(false,NET_RESULT_FAIL,response.result.error)
            }
        }
    }

    
    
}
