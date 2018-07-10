//
//  ViewController.swift
//  ApplicationLocker
//
//  Created by tramp on 2018/7/10.
//  Copyright © 2018年 tramp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            ApplicationLocker.present(type: ALLockType.creat)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

