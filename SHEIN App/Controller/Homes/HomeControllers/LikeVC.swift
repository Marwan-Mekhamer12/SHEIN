//
//  LikeVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class LikeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrData = [CartItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        BarButtonItems()
        arrData = LikesManager.share.likedItems  // used CartManager Class to Control about struct and share data not copy data!
    }
    
    func BarButtonItems() {
        let EditToDelete = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action: #selector(deleteaction))
        let deleteall = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(deleteaAllitems))
        
        
        navigationItem.rightBarButtonItems = [EditToDelete, deleteall]
    }
    
    @objc func deleteaction() {
        tableView.isEditing = !tableView.isEditing
    }
    
    @objc func deleteaAllitems() {
        if !arrData.isEmpty {
            let alert = UIAlertController(title: "Lock out...!", message: "Are you sure you want delete all of items?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete All...", style: .destructive, handler: { _ in
                self.arrData.removeAll()
                self.tableView.reloadData()
            }))
            
            present(alert, animated: true)
        }else {
            let crazyalert = UIAlertController(title: "Are you kidding me?😡", message: "you want to delete nothing idiot", preferredStyle: .alert)
            crazyalert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(crazyalert, animated: true)
        }
    }


}

extension LikeVC: UITableViewDelegate & UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likethings", for: indexPath) as! LikesTableViewCell
        let item = arrData[indexPath.row]
        cell.setup(data: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "") { _, _, code in
            self.arrData.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            code(true)
        }
        delete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
