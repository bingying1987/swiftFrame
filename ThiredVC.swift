//
//  ThiredVC.swift
//  swiftFrame
//
//  Created by MrWu on 2017/12/2.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ThiredVC: BaseVC {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
        let view = AlphaView()
        view.backgroundColor = UIColor.black
        popManager.shareInstance.showMessage(view: view)
 */
        
    }

    @IBOutlet weak var btclick: UIButton!
    
    
    @IBAction func clicked(_ sender: UIButton) {
        let view = AlphaView()
        view.frame = CGRect(x: 50, y: 0, width: 220, height: 180)
        view.backgroundColor = UIColor.black
        //这样可以把nav和tabbar 都弄进去 good
//        let toview1 = UIApplication.shared.keyWindow?.rootViewController?.view
        let toview1 = UIApplication.shared.keyWindow
        popManager.shareInstance.showViewJD(view: view, toView: (toview1)!, banimate: true, vc: self)
    }
    
    @IBOutlet weak var tuisongClick: UIButton!
    
    @IBAction func tuisongClicked(_ sender: UIButton) {
        let view = AlphaView()
        view.backgroundColor = UIColor.white
        popManager.shareInstance.showMessage(view: view)
    }
    
    @IBOutlet weak var popcenter: UIButton!
    
    @IBAction func popcenterClick(_ sender: UIButton) {
//        let view = AlphaView()
        let view = tstView()
        view.frame = CGRect(x: 0, y: 0, width: 220, height: 180)
        view.backgroundColor = UIColor.black
        /*
        view.btone.rx.controlEvent([.touchUpInside]).asObservable().subscribe(onNext: { [weak view] in
            D_DEBUG(message: "111")
            view?.btone.setTitle("111", for: UIControlState.normal)
        }).disposed(by: disposeBag)
 */
        view.btone.rx.tap.subscribe(onNext: {
            [weak view] in
            view?.btone.setTitle("111", for: .normal)
        }).disposed(by: disposeBag)
        popManager.shareInstance.popViewCenter(view: view, banimate: true)
    }
    
    @IBAction func popbottom(_ sender: UIButton) {
        let view = AlphaView()
        view.frame = CGRect(x: 0, y: 0, width: 220, height: 180)
        view.backgroundColor = UIColor.black
        popManager.shareInstance.popCenterFromBottom(view: view, banimate: true)
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
