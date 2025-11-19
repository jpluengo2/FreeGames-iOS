//
//  ViewController.swift
//  FreeGames-iOS
//
//  Created by Mananas on 12/11/25.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var filteredGameList: [Game] = []
    var originalGameList: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //tableView.dataSource = self
        
        getAllGames()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGameList = originalGameList
        } else {
            filteredGameList = originalGameList.filter { it in
                it.title.range(of: searchText, options: .caseInsensitive) != nil
                || it.genre.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Game Cell", for: indexPath) as! GameViewCell
        let game = filteredGameList[indexPath.row]
        cell.render(game: game)
        return cell
    }

    func getAllGames() {
        Task {
            originalGameList = await ServiceApi().getAllGames()
            filteredGameList = originalGameList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let game = filteredGameList[indexPath.row]
        detailVC.game = game
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

