//
//  ALKeyButton.swift
//  ApplicationLocker
//
//  Created by tramp on 2018/7/10.
//  Copyright © 2018年 tramp. All rights reserved.
//

import UIKit

enum ALKeyButtonAction {
    case delete
    case clear
    case key
    case none
}

class ALKeyButton: UIButton {
    
    // MARK: - 开放属性
    var value: String?
    var action: ALKeyButtonAction = ALKeyButtonAction.none
}
