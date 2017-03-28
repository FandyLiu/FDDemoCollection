//
//  ViewController.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func 我要申请(_ sender: UIButton) {
        let aapp = ApplyBaseViewController()
        navigationController?.pushViewController(aapp, animated: true)
    }

    @IBAction func 帮人申请(_ sender: UIButton) {
    }
}

