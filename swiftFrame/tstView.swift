//
//  tstView.swift
//  swiftFrame
//
//  Created by MrWu on 2017/12/8.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class tstView: UIView {
    var signedIn: Observable<Void>?
    @IBOutlet weak var btone: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp()
    {
        let viewtop:UIView = Bundle.main.loadNibNamed("tstView", owner: self, options: nil)?.first as! UIView
        viewtop.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(viewtop)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBAction func btClick(_ sender: UIButton) {
    }
    
}
