//
//  DetailViewController.swift
//  FreeGames-iOS
//
//  Created by Mananas on 17/11/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var processorLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    @IBOutlet weak var graphicsLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = game.title
        
        getGameById()
    }
    
    func loadData() {
        thumbnailImageView.loadFrom(url: game.thumbnail)
        
        titleLabel.text = game.title
        descriptionTextView.text = game.description
        
        genreLabel.text = game.genre
        
        if game.platform == "Web Browser" {
            platformImageView.image = UIImage(systemName: "globe")
        } else {
            platformImageView.image = UIImage(systemName: "desktopcomputer")
        }
        
        if let systemRequiremente = game.minSystemRequirements {
            osLabel.text = systemRequiremente.os
            processorLabel.text = systemRequiremente.processor
            memoryLabel.text = systemRequiremente.memory
            graphicsLabel.text = systemRequiremente.graphics
            storageLabel.text = systemRequiremente.storage
        } else {
            osLabel.text = "-----"
            processorLabel.text = "-----"
            memoryLabel.text = "-----"
            graphicsLabel.text = "-----"
            storageLabel.text = "-----"
        }
    }

    func getGameById() {
        Task {
            game = await ServiceApi().getGameById(id: game.id)
            
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
}
