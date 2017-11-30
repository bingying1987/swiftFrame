//
//  MBProgressHUD+MyHUD.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//
import Foundation
import UIKit
import MBProgressHUD
extension MBProgressHUD
{
    private static func lastWindow() ->UIWindow
    {
        let windows = UIApplication.shared.windows;
        for window in windows.reversed() {
            if(window .isKind(of: UIWindow.self) && window.bounds == UIScreen.main.bounds)
            {
                //by MrWu 2016.10.11
                //再IOS9上的系统,键盘弹出时最顶层的窗口是UIRemoteKeyboardWindow
                //如果在键盘关闭的同时调用makeToast.因为makeToast是把提示语家在最顶层
                //window上，就会导致提示语一闪而过甚至看不见，因此不加在UIRemoteKeyboardWindow
                //上.
                //IOS9以下系统没这个问题,最顶层不是UIRemoteKeyboardWindow
                //IOS9以下键盘窗口不会以window的形式加入到[UIApplication sharedApplication].windows里面.所以不会出现这个问题
                let classStr = window.classForCoder.description();
                if(classStr == "UIRemoteKeyboardWindow")
                {
                    //找到的是键盘窗口则继续
                    continue
                }
                return window
            }
        }
        
        return UIApplication.shared.keyWindow!
    }

    static func showSuccess(success:String)
    {
        self.showSuccess(success: success, toView: nil)
    }

    static func showSuccess(success:String,toView:UIView?)
    {
        self.show(text: success, icon: "success.png", toView: toView)
    }
    
    private static func show(text:String,icon:String,toView:UIView?)
    {
        var view:UIView
        if(toView == nil)
        {
            view = self.lastWindow()
        }
        else
        {
            view = toView!
        }
        
        let hud = self.showAdded(to: view, animated: true)
        /*
         // 设置图片
         hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
         */
        
        hud.mode = MBProgressHUDMode.text
        hud.removeFromSuperViewOnHide = true
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: 1.0)
    }

    static func showError(error:String)
    {
        self.showError(error: error, toView: nil)
    }
    
    static func showError(error:String,toView:UIView?)
    {
        self.show(text: error, icon: "error.png", toView: toView)
    }

    static func showMessage(message:String)
    {
        self.showMessage(message: message, toView: nil)
    }
    
    static func showMessage(message:String,toView:UIView?)
    {
        var view:UIView
        if(toView == nil)
        {
            view = self.lastWindow()
        }
        else
        {
            view = toView!
        }
        
        let hud = self.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.text
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
        hud.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.2)
        
    }

    static func hideHUD()
    {
        self.hideHUDForView(view: nil)
    }
    
    static func hideHUDForView(view:UIView?)
    {
        var viewtmp:UIView
        if(view == nil)
        {
           viewtmp = self.lastWindow()
        }
        else
        {
            viewtmp = view!
        }
        
        //这里我们确保动画在主线程中完成(如异步线程请求结束后关闭hud)
        DispatchQueue.main.async {
            self.hide(for: viewtmp, animated: true)
        }
    }






}
