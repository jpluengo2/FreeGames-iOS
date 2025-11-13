//
//  ViewController.swift
//  FreeGames-iOS
//
//  Created by Mananas on 12/11/25.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var gameList: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        getAllGames()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Game Cell", for: indexPath) as! GameViewCell
        let game = gameList[indexPath.row]
        cell.render(game: game)
        return cell
    }

    func getAllGames() {
        Task {
            gameList = await ServiceApi().getAllGames()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}

