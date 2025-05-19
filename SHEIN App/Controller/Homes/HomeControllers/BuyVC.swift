//
//  BuyVC.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import UIKit

class BuyVC: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var arrData = [CartItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        barButtomItems()
        arrData = CartManager.shared.cartItems
    }
    
    func barButtomItems() {
        let pencilButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .done, target: self, action: #selector(Edit))
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(deleteItem))
        
        navigationItem.rightBarButtonItems = [pencilButton, deleteButton]
    }
    
    @objc func Edit() {
        tableView.isEditing = !tableView.isEditing
    }
    
    @objc func deleteItem() {
        DeleteActionShit()
    }
    
    func DeleteActionShit() {
        if !arrData.isEmpty{
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
    
    @IBAction func GpToPayNowView(_ sender: UIButton) {
        if !arrData.isEmpty {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "pay") as? PayNowVC {
                vc.title = "Pay Now!"
                vc.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            // alert controller
            ItemsIsEmpty()
        }
    }
    
    func ItemsIsEmpty() {
        let alert = UIAlertController(title: "How!", message: "The Items is Empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
        
    }
    
    
    
}

extension BuyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table", for: indexPath) as! BuyTableViewCell
        let item = arrData[indexPath.row]
        cell.setup(data: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let item = arrData[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let delete = UIContextualAction(style: .destructive, title: "", handler: { _, _, code in
             self.arrData.remove(at: indexPath.row)
             tableView.beginUpdates()
             tableView.deleteRows(at: [indexPath], with: .automatic)
             tableView.endUpdates()
             code(true)
        })
        
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

