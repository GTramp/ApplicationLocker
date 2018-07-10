//
//  ALIndicatorBar.swift
//  ApplicationLocker
//
//  Created by tramp on 2018/7/10.
//  Copyright © 2018年 tramp. All rights reserved.
//

import UIKit

fileprivate let AL_POINT_W_H:CGFloat = 20.0
fileprivate let AL_POINT_COUNT = 6

class ALIndicatorBar: UIView {
    
    // MARK: - 开放属性
    
    /// point
    var current: Int = 0 {
        didSet {
            updateUi(count: current)
        }
    }

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
        
        let margin = (frame.width - CGFloat(AL_POINT_COUNT) * AL_POINT_W_H) / CGFloat(AL_POINT_COUNT + 1)
        let point_y = (frame.height - AL_POINT_W_H) * 0.5
        for (index, point) in subviews.enumerated() {
            let piont_x = margin + (AL_POINT_W_H + margin) * CGFloat(index)
            point.frame = CGRect.init(x: piont_x, y: point_y, width: AL_POINT_W_H, height: AL_POINT_W_H)
        }
    }
}

// MARK: - 响应方法
extension ALIndicatorBar {
    
    /// updateUi
    ///
    /// - Parameter count: Int
    func updateUi(count: Int) {
        if count > AL_POINT_COUNT { return }
        
        for (index, point) in subviews.enumerated() {
            if index < count {
                point.backgroundColor = UIColor.white
            } else {
                point.backgroundColor = UIColor.clear
            }
        }
    }
}

// MARK: - ALIndicatorBar
extension ALIndicatorBar {
    
    /// initialization
    private func initialization() {
        // points
        for _ in 0 ..< AL_POINT_COUNT {
            let point = UIView.init(frame: CGRect.init(x: 0, y: 0, width: AL_POINT_W_H, height: AL_POINT_W_H))
            point.layer.cornerRadius = AL_POINT_W_H * 0.5
            point.layer.masksToBounds = true
            point.layer.borderColor = UIColor.white.cgColor
            point.layer.borderWidth = 2.0
            
            addSubview(point)
        }
    }
}
