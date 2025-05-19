//
//  SearchVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class SearchVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!

    var arrData = [Main]()  // main data from api
    var filteredData = [Main]()  // to filter search
    let manager = ManagerBrain()  // api file
    let searchController = UISearchController(searchResultsController: nil)  // for search contoller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        setupSearchController()  // for search contoller
        
        manager.fetchRequest { posts in  // for passing data
            DispatchQueue.main.async {
                self.arrData = posts
                self.filteredData = posts
                self.tableView.reloadData()
            }
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search items..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

  // Marwan: - Table View Functions

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryyyyyy", for: indexPath) as! CategoryTableViewCell
        let items = filteredData[indexPath.row]
        cell.setup(data: items)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let items = filteredData[indexPath.row]
        print(items.title)
        view.endEditing(true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "select") as? SelectedFromCollectionVC {
            vc.photo = items.images.first
            vc.name = items.title
            vc.price = "\(items.price)"
            vc.category = items.category
            vc.descriptionyy = items.description
            vc.rating = "\(items.rating)"
            vc.stock = "\(items.stock)"
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

  // Marwan: - UI Search Controller

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        if searchText.isEmpty {
            filteredData = arrData
        } else {
            filteredData = arrData.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}
