//
//  MyPopView.swift
//  swiftFrame
//
//  Created by MrWu on 2017/12/2.
//  Copyright © 2017年 mac. All rights reserved.
//

//注意调用此类传入的view需要在外部设置好frame


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
        case popMessage,popViewJD,popCenter
    }
    var currentType:popType
    var JDView:UIView?//如果时京东模式，这里代表底视图
    var bNeedAnimate:Bool //记录弹出时是否有动画,弹出时有动画的话，默认关闭时也有动画
    private let AlphaViewTag = 101
    private let ContentViewTag = 102
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
    private override init(){
        currentType = .popMessage
        bNeedAnimate = true
    }
    
    func showMessage(view:UIView)
    {
        currentType = .popMessage
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
    
    
    func showViewJD(view:UIView,toView:UIView,banimate:Bool,vc:UIViewController?)
    {
        popViewJD(view: view, toView: toView,banimate:banimate,vc: vc!)
    }
    
    
    //京东商品详情样式弹出动画
    private func AnimateJDBegin() ->CATransform3D
    {
        var t1 = CATransform3DIdentity
        t1.m34 = -1.0/900 //m34表示近大远小效果, -1.0/d,d表示距离
        //带点缩小的效果
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        //绕x轴旋转
        t1 = CATransform3DRotate(t1, CGFloat(15.0 * M_PI/180.0), 1, 0, 0)
        return t1
    }
    
    private func AnimateJDEnd() ->CATransform3D
    {
        var t1 = CATransform3DIdentity
        t1.m34 = -1.0/900 //m34表示近大远小效果, -1.0/d,d表示距离
        t1 = CATransform3DScale(t1, 1, 1, 1)
        //绕x轴旋转
        t1 = CATransform3DRotate(t1, CGFloat(15.0 * M_PI/180.0), 1, 0, 0)
        return t1
    }
    
    
    func popViewJD(view:UIView,toView:UIView,banimate:Bool,vc:UIViewController?)
    {
        currentType = .popViewJD
        bNeedAnimate = banimate
        let window = lastWindow()
        let alphi = AlphaView()
        alphi.frame = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        alphi.backgroundColor = UIColor.lightGray
        alphi.alpha = 0.25
        alphi.tag = AlphaViewTag
        alphi.isUserInteractionEnabled = true
        alphi.delegate = self
        view.tag = ContentViewTag
        JDView = toView
        window.addSubview(alphi)
        window.addSubview(view)
//        window.addSubview(view)
        if banimate {
            view.center.y = DEVICE_HEIGHT + view.frame.size.height / 2
            UIView.animate(withDuration: 0.5, animations: {
                [weak self] in
                toView.layer.transform = (self?.AnimateJDBegin())!
            }) { (finished) in
                UIView.animate(withDuration: 0.3, animations: {
                    
                    toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.95)
                    view.center.y = DEVICE_HEIGHT - view.frame.height / 2
                })
            }
        }
        else
        {
            toView.layer.transform = (self.AnimateJDBegin())
            toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.95)
            view.center.y = DEVICE_HEIGHT - view.frame.height / 2
        }
        
    }
    
    private func closeViewJD(_ banimate:Bool)
    {
        let keywindow = lastWindow()
        let viewAlpha = keywindow.viewWithTag(AlphaViewTag)
        let contentView = keywindow.viewWithTag(ContentViewTag)
        
        if banimate {
            UIView.animate(withDuration: 0.5, animations: {[weak self] in
                contentView?.center.y = DEVICE_HEIGHT + (contentView?.frame.size.height)! / 2
                self?.JDView?.layer.transform = (self?.AnimateJDEnd())!
                }, completion: { [weak self](finished) in
                    contentView?.removeFromSuperview()
                    viewAlpha?.removeFromSuperview()
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.JDView?.transform = CGAffineTransform(scaleX: 1, y: 1);
                    }, completion: { [weak self](finished) in
                        self?.JDView = nil
                    })
            })
        }
        else
        {
            contentView?.removeFromSuperview()
            viewAlpha?.removeFromSuperview()
            self.JDView?.transform = CGAffineTransform(scaleX: 1, y: 1);
            self.JDView = nil
        }
        

    }
    //常规中间弹出
    func popViewCenter(view:UIView,banimate:Bool)
    {
        bNeedAnimate = banimate
        currentType = .popCenter
        
        view.frame = CGRect(x: (DEVICE_WIDTH - view.frame.size.width) / 2, y: (DEVICE_HEIGHT - view.frame.height) / 2, width: view.frame.size.width, height: view.frame.size.height)
        
        let window = lastWindow()
        let alphi = AlphaView()
        alphi.frame = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        alphi.backgroundColor = UIColor.lightGray
        alphi.alpha = 0.25
        alphi.tag = AlphaViewTag
        alphi.isUserInteractionEnabled = true
        alphi.delegate = self
        view.tag = ContentViewTag
        window.addSubview(alphi)
        window.addSubview(view)
        
        if banimate {
            view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            view.alpha = 0.3
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                view.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func closePopCenter(_ banimate:Bool)
    {
        let keywindow = lastWindow()
        let viewAlpha = keywindow.viewWithTag(AlphaViewTag)
        let contentView = keywindow.viewWithTag(ContentViewTag)
        if banimate {
            UIView.animate(withDuration: 0.2, animations: {
                contentView?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                contentView?.alpha = 0.3
            }, completion: { (finished) in
                contentView?.removeFromSuperview()
                viewAlpha?.removeFromSuperview()
            })
        }
        else
        {
            contentView?.removeFromSuperview()
            viewAlpha?.removeFromSuperview()
        }
    }
    
    //常规中间弹出，从底部上来
    func popCenterFromBottom(view:UIView,banimate:Bool)
    {
        bNeedAnimate = banimate
        currentType = .popCenter
        
        view.frame = CGRect(x: (DEVICE_WIDTH - view.frame.size.width) / 2, y: DEVICE_HEIGHT , width: view.frame.size.width, height: view.frame.size.height)
        let window = lastWindow()
        let alphi = AlphaView()
        alphi.frame = CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        alphi.backgroundColor = UIColor.lightGray
        alphi.alpha = 0.25
        alphi.tag = AlphaViewTag
        alphi.isUserInteractionEnabled = true
        alphi.delegate = self
        view.tag = ContentViewTag
        window.addSubview(alphi)
        window.addSubview(view)
        
        if banimate {
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
            UIView.animate(withDuration: 0.3, animations: {
                view.center = CGPoint(x: DEVICE_WIDTH / 2, y: DEVICE_HEIGHT / 2)
            }, completion: {
                (finished) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
                    view.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                }, completion: nil)
            })
            
            
                /*
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
                    view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 4))
                }, completion: nil)
 */
            
        }
    }
    
    
    func hidePopView(_ banimate:Bool)
    {
        switch currentType {
        case .popMessage:
            break
        case .popViewJD:
            closeViewJD(banimate)
            break
        case .popCenter:
            closePopCenter(banimate)
            break
        }
    }
    
    func OnClick() {
        hidePopView(bNeedAnimate)
    }
 
}

