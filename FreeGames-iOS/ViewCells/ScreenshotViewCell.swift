//
//  ScreenshotViewCell.swift
//  FreeGames-iOS
//
//  Created by Mananas on 18/11/25.
//

import UIKit

class ScreenshotViewCell: UICollectionViewCell {
    
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    func render(url: String) {
        screenshotImageView.loadFrom(url: url)
    }
}
