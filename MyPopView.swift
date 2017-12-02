//
//  MyPopView.swift
//  swiftFrame
//
//  Created by MrWu on 2017/12/2.
//  Copyright © 2017年 mac. All rights reserved.
//
import Foundation

protocol AlphaViewDelegate:NSObjectProtocol{
    func OnClick()
}

class AlphaView:UIView
{
    weak var delegate:AlphaViewDelegate?
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.OnClick()
    }
    
    deinit {
        D_DEBUG(message: "AlphaView delloc")
    }
}


class popManager:NSObject,AlphaViewDelegate
{
    enum popType {
        case popMessage
    }
    
    private func lastWindow() ->UIWindow
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
    
    
    static let shareInstance = popManager()
    private override init(){}
    
    func showMessage(view:UIView)
    {
        //总是跟导航栏一样高
        view.frame = CGRect(x: 0, y: -64, width: DEVICE_WIDTH, height: 64)
        lastWindow().addSubview(view)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 6.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.lastWindow().bringSubview(toFront: view)
            view.center.y = 32
        }) {(finished) in
            UIView.animate(withDuration: 1.0, delay: 3.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 6.0, options: .curveEaseInOut, animations: {
                view.center.y = -32
            }, completion: { (finished) in
                view.removeFromSuperview()
            })
        }
    }
    
    
    func show(view:UIView,type:popType)
    {
        switch type {
        case .popMessage:
            showMessage(view: view)
        }
    }
    
    func OnClick() {
        
    }
 
}

