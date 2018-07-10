//
//  ALKeyBoard.swift
//  ApplicationLocker
//
//  Created by tramp on 2018/7/10.
//  Copyright © 2018年 tramp. All rights reserved.
//

import UIKit
import AudioToolbox

fileprivate let AL_KEY_W_H: CGFloat = 80
fileprivate let AL_KEY_ROW_COUNT = 3
fileprivate let AL_KEY_COLUMN_COUNT = 4

@objc protocol ALKeyBoradDelegate {
    
    /// keyBoardClearAction
    ///
    /// - Parameter keyBoard: ALKeyBoard
    @objc optional func keyBoardClearAction(keyBoard: ALKeyBoard)
    
    /// keyBoradDeleteAction
    ///
    /// - Parameters:
    ///   - keyBoard: ALKeyBoard
    ///   - text: String
    @objc optional func keyBoradDeleteAction(keyBoard: ALKeyBoard, text: String)
    
    /// keyBoardValueChangeed
    ///
    /// - Parameters:
    ///   - keBorad: ALKeyBoard
    ///   - text: String
    @objc optional func keyBoardValueChangeed(keBorad: ALKeyBoard, text: String)
}

class ALKeyBoard: UIView {
    
    // MARK: - 开放属性
    /// ALKeyBoradDelegate
    weak var delegate: ALKeyBoradDelegate?
    
    // MARK: - 私有属性
    
    /// password
    private lazy var passwrod = String.init()

    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // initialization
        initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin_x = (frame.width - AL_KEY_W_H * CGFloat(AL_KEY_ROW_COUNT)) / CGFloat(AL_KEY_ROW_COUNT - 1)
        let margin_y = (frame.height - CGFloat(AL_KEY_COLUMN_COUNT) * AL_KEY_W_H) / CGFloat(AL_KEY_COLUMN_COUNT - 1)
        for (index, keyButton) in subviews.enumerated() {
            let key_x = (AL_KEY_W_H + margin_x) * CGFloat(index % AL_KEY_ROW_COUNT)
            let key_y = (AL_KEY_W_H + margin_y) * CGFloat(index / AL_KEY_ROW_COUNT)
            keyButton.frame = CGRect.init(x: key_x, y: key_y, width: AL_KEY_W_H, height: AL_KEY_W_H)
        }
    }
}

// MARK: - 响应方法
extension ALKeyBoard {
    
    /// key action handler
    ///
    /// - Parameter sender: UIButton
    @objc private func keyActionHandler(_ sender: ALKeyButton) {
        AudioServicesPlaySystemSound(1105)
        
        if sender.action == ALKeyButtonAction.clear, passwrod.count > 0 { // clear
            
            passwrod.removeAll()
            // delegate
            delegate?.keyBoardClearAction?(keyBoard: self)
            
        } else if sender.action == ALKeyButtonAction.delete, passwrod.count > 0 { // delete
            
            passwrod.removeLast()
            // delegate
            delegate?.keyBoradDeleteAction?(keyBoard: self, text: passwrod)
            
        } else if sender.action == ALKeyButtonAction.key { // key
            
            guard let value = sender.value, passwrod.count < 6 else  { return }
            passwrod.append(value)
            // deleate
            delegate?.keyBoardValueChangeed?(keBorad: self, text: passwrod)
        }
        
    }
}

// MARK: - initialization
extension ALKeyBoard {
    
    /// initialization
    private func initialization(){
        
        // default
        // key
        let keys = ["1","2","3","4","5","6","7","8","9","clear","0","delete"]
        
        for key in keys {
            let keyButton = ALKeyButton.init(type: UIButtonType.custom)
            keyButton.titleLabel?.font = UIFont.systemFont(ofSize: 28.0, weight: UIFont.Weight.bold)
            keyButton.layer.cornerRadius = AL_KEY_W_H * 0.5
            keyButton.setBackgroundImage(UIImage.init(named: "lock_key_normal"), for: UIControlState.normal)
            keyButton.setBackgroundImage(UIImage.init(named: "lock_key_highlighted"), for: UIControlState.highlighted)
            
            keyButton.addTarget(self, action: #selector(keyActionHandler(_:)), for: UIControlEvents.touchUpInside)
            
            if key == "clear" {
                keyButton.setImage(UIImage.init(named: "key_clear"), for: UIControlState.normal)
                keyButton.action = ALKeyButtonAction.clear
            } else if key == "delete" {
                keyButton.setImage(UIImage.init(named: "key_delete"), for: UIControlState.normal)
                keyButton.action = ALKeyButtonAction.delete
            } else {
                keyButton.setTitle(key, for: UIControlState.normal)
                keyButton.value = key
                keyButton.action = ALKeyButtonAction.key
            }
            addSubview(keyButton)
        }
    }
    
}
