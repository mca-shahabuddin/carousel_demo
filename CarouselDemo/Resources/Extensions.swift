//
//  Extensions.swift
//  CarouselDemo
//
//  Created by Shahabuddin Vansiwala on 20/07/22.
//

import UIKit

extension UIImageView {
    func loadImage(imageUrl: String, Placeholder: UIImage) {
        DispatchQueue.global(qos: .background).async {
            do{
                guard let url = URL(string: imageUrl) else {
                    self.image = Placeholder
                    return
                }
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if let loadedImage = UIImage(data: imageData) {
                            self.image = loadedImage
                        }
                    }
                } else {
                    self.image = Placeholder
                }
            }
        }
    }
}
extension UIView {
    func roundCorners(radius: CGFloat, borderColor: UIColor) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor.cgColor
    }
}
extension Optional where Wrapped == String {
    var toString: String {
        return self?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) ?? ""
    }
}
extension UITableView {
    func showNoDataMessage(message: String) {
        let lblMsg = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMsg.text = message
        lblMsg.textColor = .black
        lblMsg.numberOfLines = 0
        lblMsg.textAlignment = .center
        lblMsg.sizeToFit()

        self.backgroundView = lblMsg
        self.separatorStyle = .none
    }

    func hideNoDataMessage() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
