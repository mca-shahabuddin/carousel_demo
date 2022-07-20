//
//  BannerViewCell.swift
//  CarouselDemo
//
//  Created by Shahabuddin Vansiwala on 20/07/22.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imageViewBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewMain.roundCorners(radius: 0.0, borderColor: AppColor.bannerViewBorder)
    }
}
