//
//  ViewController.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/22.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var cityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func choose(_ sender: UIButton) {
        
        let choseViewController = ChooseViewController { [weak self] (str) in
            guard let strongSelf = self else { return }
            strongSelf.cityLabel.text = str
        }
        navigationController?.pushViewController(choseViewController, animated: true)
    }

}

