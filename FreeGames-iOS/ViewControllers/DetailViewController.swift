//
//  DetailViewController.swift
//  FreeGames-iOS
//
//  Created by Mananas on 17/11/25.
//

import UIKit
import AVKit
//import AVFoundation

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var videoPlayerView: UIView!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var platformImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var processorLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    @IBOutlet weak var graphicsLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    // MARK: Properties
    
    var game: Game!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = game.title
        
        //screenshotsCollectionView.dataSource = self
        //screenshotsCollectionView.delegate = self
        
        getGameById()
        
        //playVideo()
        videoPlayerView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPlayerView.layer.sublayers?.first?.frame = videoPlayerView.bounds
    }
    
    // MARK: CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.screenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = screenshotsCollectionView.dequeueReusableCell(withReuseIdentifier: "Screenshot Cell", for: indexPath) as! ScreenshotViewCell
        cell.render(url: game.screenshots![indexPath.row].image)
        return cell
    }
    
    // MARK: CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let screenshot = game.screenshots![indexPath.row]
        thumbnailImageView.loadFrom(url: screenshot.image)
    }
    
    // MARK: VideoPlayer
    
    func playVideo() {
        let url = URL(string: "https://www.freetogame.com/g/\(game.id)/videoplayback.webm")!
        let player = AVPlayer(url: url)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.bounds
        playerLayer.videoGravity = .resizeAspectFill

        videoPlayerView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    // MARK: Actions
    
    @IBAction func expandDescription(_ sender: UIButton) {
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 5
            sender.setImage(UIImage(systemName: "arrow.up.and.line.horizontal.and.arrow.down"), for: .normal)
        } else {
            descriptionLabel.numberOfLines = 0
            sender.setImage(UIImage(systemName: "arrow.down.and.line.horizontal.and.arrow.up"), for: .normal)
        }
    }
    
    @IBAction func shareContent(_ sender: Any) {
        let text = "Check out this game: \(game.title) - \(game.profileUrl)"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func playNow(_ sender: Any) {
        if let url = URL(string: game.gameUrl) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: Buisness Logic
    
    func getGameById() {
        Task {
            game = await ServiceApi().getGameById(id: game.id)
            
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
    
    func loadData() {
        thumbnailImageView.loadFrom(url: game.thumbnail)
        
        titleLabel.text = game.title
        descriptionLabel.text = game.description
        // descriptionLabel.numberOfLines = 0
        //descriptionLabel.sizeToFit()
        
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
        
        let screenshot = Screenshot(image: game.thumbnail)
        game.screenshots?.insert(screenshot, at: 0)
        
        screenshotsCollectionView.reloadData()
    }
}
