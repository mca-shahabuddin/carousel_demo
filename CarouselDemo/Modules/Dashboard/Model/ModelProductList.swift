//
//  ModelProductList.swift
//  CarouselDemo
//
//  Created by Shahabuddin Vansiwala on 20/07/22.
//

import UIKit

struct ModelProductList: Codable {
    let title: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case title, image
    }
}
