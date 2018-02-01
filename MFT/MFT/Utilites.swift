//
//  Utilites.swift
//  MFT
//
//  Created by leejaesung on 2018. 1. 28..
//  Copyright © 2018년 blackturtle2. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIView
extension UIView {
    
    // 스토리보드에서 UIButton의 border width, color와 cornerRaius를 설정할 수 있는 Extension.
    // ref: https://stackoverflow.com/questions/28854469/change-uibutton-bordercolor-in-storyboard
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
