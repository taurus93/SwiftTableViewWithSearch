//
//  ViewController.swift
//  TableViewWithSearch
//
//  Created by drjadm on 3/9/20.
//  Copyright © 2020 drjadm. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var tableview: UITableView!
    var names: [[String]] =
           [
               ["薬剤名昇順", "薬剤名降順", "薬価（安い順）", "薬価（高い順）"],
               ["先発品のみ", "後発品のみ"],
               ["共和薬品工業", "東和製品", "ニプロ", "大塚製薬", "大原薬品工業", "共創未来ファーマ", "日医工", "沢井製薬", "田辺三菱製薬株式会社", "日本ジェネリック", "メディサ新薬"]
       ]
    var titles: [String] = ["並び替え", "絞り込み", "製造会社絞り込み（複数選択可）"]
    var searchResults = [[String]]()
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        //register cell
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        searchResults = names
        print(searchResults)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.tableHeaderView = searchController.searchBar
        //delegate & datasouce
        tableview.delegate = self
        tableview.dataSource = self
    }
    

}
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults[section].count : names[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if (searchController.isActive) {
            cell.textLabel?.text = searchResults[indexPath.section][indexPath.row]
            return cell
        }
        else {
            cell.textLabel?.text = names[indexPath.section][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected cell: \(names[indexPath.row])")
        let cell = tableview.cellForRow(at: indexPath)
        print(cell)
        print(indexPath)
//        cell?.selectionStyle = .none
//        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
//        if (cell?.accessoryType == .checkmark) {
//            cell?.accessoryType = .none
//        } else {
//            cell?.accessoryType = .checkmark
//        }
//        switch indexPath {
//        case [0, 0]:
//            tableview.cellForRow(at: [0, 1] as IndexPath)?.accessoryType = .none
//        case [0, 1]:
//            tableview.cellForRow(at: [0, 0] as IndexPath)?.accessoryType = .none
//        case [0, 2]:
//            tableview.cellForRow(at: [0, 3] as IndexPath)?.accessoryType = .none
//        case [0, 3]:
//            tableview.cellForRow(at: [0, 2] as IndexPath)?.accessoryType = .none
//        case [1, 0]:
//            tableview.cellForRow(at: [1, 1] as IndexPath)?.accessoryType = .none
//        case [1, 1]:
//            tableview.cellForRow(at: [1, 0] as IndexPath)?.accessoryType = .none
//        default:
//            break
//        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func filterContent(for searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        if (searchText != "") {
            let result: [String] = names[2].filter({ item -> Bool in
                let match = item.range(of: searchText, options: .caseInsensitive)
                // Return the tuple if the range contains a match.
                return match != nil
            })
            searchResults[2] = result
        } else {
            
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If the search bar contains text, filter our data with the string
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload the table view with the search result data.
            tableview.reloadData()
        }
    }
}
