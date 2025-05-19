//
//  ViewController.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 14/05/2025.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collection: UICollectionView!
    
    var arrData = [Main]()
    var manager = ManagerBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        barButtonItem()
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collection.delegate = self
        collection.dataSource = self
        
        manager.fetchRequest { posts in
            DispatchQueue.main.async {
                self.arrData = posts
                self.collectionView1.reloadData()
                self.collection.reloadData()
            }
            
        }
    }
    
    func barButtonItem() {
        let barlike = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(like))
        let barbuy = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(cart))
        navigationItem.rightBarButtonItems = [barlike, barbuy]
    }
    
    @objc func like() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "like") as? LikeVC {
            vc.title = "Favourites"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func cart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "buy") as? BuyVC {
            vc.title = "Cart"
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

  // Marwan: - Collection View
extension Home: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return arrData.count
        }else {
            return arrData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell1
            let photo = arrData[indexPath.row]
            cell.setup(ImageURL: photo)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CollectionViewCell2
            let photo = arrData[indexPath.row]
            cell.setUp(pro: photo)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = arrData[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "select") as? SelectedFromCollectionVC {
            vc.photo = item.images.first
            vc.name = item.title
            vc.price = "\(item.price)"
            vc.category = item.category
            vc.descriptionyy = item.description
            vc.rating = "\(item.rating)"
            vc.stock = "\(item.stock)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
