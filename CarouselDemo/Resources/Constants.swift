//
//  Constants.swift
//  CarouselDemo
//
//  Created by Shahabuddin Vansiwala on 20/07/22.
//

import UIKit

var placeHolderImage = UIImage() {
    didSet {
        if let _image = UIImage(named:"imageplaceholder") {
            placeHolderImage = _image
        }
    }
}

struct AppColor {
    static let appIndicatorColor = UIColor.lightGray
    static let appCurrentIndicatorColor = UIColor.init(red: 245.0/255.0, green: 47.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    
    static let bannerViewBorder = UIColor.lightGray
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.nativeBounds.width
    static let screenHeight = UIScreen.main.nativeBounds.height
}
