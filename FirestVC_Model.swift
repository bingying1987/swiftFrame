//
//  FirestVC_Model.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import HandyJSON
class BannerImage: HandyJSON {
    var carId:String?
    var carTitle:String?
    var carImgurl:String?
    var carContent:String?
    var carType:String?
    var carSpan1:String?
    var carSpan2:String?
    var carSpan3:String?
    var carSpan4:String?
    var carSpan5:String?
    required init(){}
}

class BannerModel:  HandyJSON{
    var t:Array<BannerImage>?
    required init(){}
}
