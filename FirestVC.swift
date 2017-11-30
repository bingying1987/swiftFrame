//
//  FirestVC.swift
//  swiftFrame
//
//  Created by MrWu on 2017/11/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import RxSwift

class FirestVC: BaseVC {
    @IBOutlet weak var bannerView: MyScrollView!
    
    
    let m_VM = FirstVC_VM()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
//        m_VM.GetBanner()
        m_VM.Rx_GetBanner().subscribe { [weak self](event) in
            switch event
            {
            case .success( _):
                D_DEBUG(message: "111111")
                self?.m_VM.Rx_GetBannerImgUrls().subscribe({ [weak self](event) in
                    switch event
                    {
                    case .success(let imgarray):
                        self?.bannerView .UpdateScrollView(eventTarget: self!, dataarray: imgarray)
                        break
                    case .error(_):
                        break
                    }
                }).disposed(by: (self?.disposeBag)!)
                break
            case .error( _):
                break
            }
        }.disposed(by: disposeBag)
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
