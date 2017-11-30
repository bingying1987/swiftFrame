//
//  ApiHelper.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#if DEBUG
let SERVER_ADDRESS = "http://test.zsjz888.com/"
#else
let SERVER_ADDRESS = "http://www.baidu.com"
#endif

let API_BANNER_HOME = "carousel/getcarouserImgByTypeIos.html?type=f0cade0c55541c96015554221b0c0101"

class ApiHelper {
    static func getApiAddress(api:String) -> String
    {
        //不在其它地方直接使用String + String的方式 是因为可能会有额外的处理
        return SERVER_ADDRESS + api
    }
}
