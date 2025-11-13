//
//  GameViewCell.swift
//  FreeGames-iOS
//
//  Created by Mananas on 12/11/25.
//

import UIKit

class GameViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 16
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func render(game: Game) {
        titleLabel.text = game.title
        platformLabel.text = game.platform
        genreLabel.text = game.genre
        thumbnailImageView.loadFrom(url: game.thumbnail)
    }
}
