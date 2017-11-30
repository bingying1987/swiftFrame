//
//  UIDevice+MyModel.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
enum Model {
    case Iphone4,Iphone5s,Iphone6,Iphone6p,Iphone6pBigModel,IPAD,UnKnow
}


extension UIDevice{
    static func DeviceModel() ->Model
    {
        if isIPhone4() {
            return Model.Iphone4
        }
        else if isIPhone5s()
        {
            return Model.Iphone5s
        }
        else if isIPhone6()
        {
            return Model.Iphone6
        }
        else if isIPhone6P()
        {
            return Model.Iphone6p
        }
        else if isIPhone6PBigMode()
        {
            return Model.Iphone6pBigModel
        }
        else if isIPad()
        {
            return Model.IPAD
        }
        else
        {
            return Model.UnKnow
        }
    }
}
