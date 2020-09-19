//
//  UIButtonExtension.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import Foundation

import UIKit

extension UIButton {
    enum ButtonLayout {
        case leftImage
        case rightImage
        case topImage
        case bottomImage
    }
//    Btn图片与文字并存
    func setLayoutType(type: ButtonLayout){
        let image: UIImage? = self.imageView?.image
        switch type {
        case .leftImage:
            print("系统默认的方式")
        case .rightImage:
            self.imageEdgeInsets = UIEdgeInsets(top:0, left: (self.titleLabel?.frame.size.width)!, bottom: 0, right:-(self.titleLabel?.frame.size.width)!)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(image?.size.width)!, bottom: 0, right: (image?.size.width)!)
        case .topImage:
            self.imageEdgeInsets = UIEdgeInsets(top:-(self.titleLabel?.frame.size.height)!, left: 0, bottom: 0, right:-((self.titleLabel?.frame.size.width)!))
            //图片距离右边框距离减少图片的宽度，距离上m边距的距离减少文字的高度
            self.titleEdgeInsets = UIEdgeInsets(top: ((image?.size.height)!), left: -((image?.size.width)!), bottom: 0, right:0)
        //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        default:
            self.imageEdgeInsets = UIEdgeInsets(top: (self.titleLabel?.frame.size.height)!, left:0, bottom: 0, right:-((self.titleLabel?.frame.size.width)!))
            //图片距离上边距增加文字的高度  距离右边距减少文字的宽度
            self.titleEdgeInsets = UIEdgeInsets(top: -(image?.size.height)!, left: -(image?.size.width)!, bottom: 0, right: 0)
        }
    }
}
