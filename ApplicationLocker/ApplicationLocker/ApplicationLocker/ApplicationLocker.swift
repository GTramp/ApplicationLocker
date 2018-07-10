//
//  ApplicationLocker.swift
//  ApplicationLocker
//
//  Created by tramp on 2018/7/10.
//  Copyright © 2018年 tramp. All rights reserved.
//

import UIKit
import SnapKit

/// ALLockType
///
/// - creat: 创建密码
/// - change: 修改密码
/// - verify: 验证密码
/// - none: none
enum ALLockType {
    case creat
    case change
    case verify
    case none
}

class ApplicationLocker: UIView {
    
    // MARK: - 私有属性

    /// lock type
    private var lockType: ALLockType = ALLockType.none
    
    /// indicator
    private lazy var indicatorBar: ALIndicatorBar = {
        let _bar = ALIndicatorBar.init()
        return _bar
    }()
    
    /// key board
    private lazy var keyBoard: ALKeyBoard = {
        let _board = ALKeyBoard.init()
        _board.delegate = self
        return _board
    }()
    
    /// UIVisualEffectView
    private lazy var effect: UIVisualEffectView = {
        let _effect = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffectStyle.dark))
        return _effect
    }()
    
    /// background
    private lazy var background: UIImageView = {
        let _background = UIImageView.init(image: UIImage.init(named: "lock"))
        _background.contentMode = UIViewContentMode.center
        return  _background
    }()
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // initialization
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ALKeyBoradDelegate
extension ApplicationLocker: ALKeyBoradDelegate {
    
    /// keyBoardClearAction
    ///
    /// - Parameter keyBoard: ALKeyBoard
    func keyBoardClearAction(keyBoard: ALKeyBoard) {
        indicatorBar.current = 0
    }
    
    /// keyBoradDeleteACtion
    ///
    /// - Parameters:
    ///   - keyBoard: ALKeyBoard
    ///   - text: String
    func keyBoradDeleteAction(keyBoard: ALKeyBoard, text: String) {
         indicatorBar.current = text.count
    }
    
    /// keyBoardValueChangeed
    ///
    /// - Parameters:
    ///   - keBorad: ALKeyBoard
    ///   - text: String
    func keyBoardValueChangeed(keBorad: ALKeyBoard, text: String) {
        indicatorBar.current = text.count
    }
}
// MARK: - 响应方法
extension ApplicationLocker {
    
    /// 展示锁屏
    ///
    /// - Parameter type: ALLockType
    class func present(type: ALLockType) {
        let locker = ApplicationLocker.init(frame: UIScreen.main.bounds)
        
        locker.lockType = type
        
        UIApplication.shared.keyWindow?.addSubview(locker)
    }
}

// MARK: - initialization
extension ApplicationLocker {
    
    /// initialization
    private func initialization() {
        
        // background
        addSubview(background)
        background.snp.makeConstraints { (mk) in
            mk.center.equalToSuperview()
        }
        
        // effect
        addSubview(effect)
        effect.snp.makeConstraints { (mk) in
            mk.edges.equalToSuperview()
        }
        
        // key board
        addSubview(keyBoard)
        keyBoard.snp.makeConstraints { (mk) in
            mk.centerX.equalToSuperview()
            mk.centerY.equalToSuperview().offset(50.0)
            mk.width.equalTo(300.0)
            mk.height.equalTo(400.0)
        }
        
        // bar
        addSubview(indicatorBar)
        indicatorBar.snp.makeConstraints { (mk) in
            mk.left.right.equalTo(keyBoard)
            mk.centerX.equalToSuperview()
            mk.bottom.equalTo(keyBoard.snp.top).offset(-32.0)
            mk.height.equalTo(50.0)
        }
    }
}
