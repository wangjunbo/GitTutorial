//
//  RestaurantTableViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/2.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit
import ContactsUI

class RestaurantTableViewController: UITableViewController {
    
    //MARK: restaurant view controller
    let restaurantInfo = RestaurantInfo()

    private let contactPicker = CNContactPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        if let customFont = UIFont(name: "KohinoorTelugu-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor:UIColor(red:231.0/255.0,green: 76.0/255.0,blue: 60.0/255.0 ,alpha: 1.0),NSAttributedString.Key.font:customFont
            ]
        }
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantInfo.restaurants.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell1", for: indexPath) as! RestaurantTableViewCell
        cell.nameLabel?.text = restaurantInfo.restaurants[indexPath.row].name
//        cell.thumbnailImageView?.image = UIImage(named: restaurant.restaurantImages[indexPath.row] )
        cell.imageName = restaurantInfo.restaurants[indexPath.row].image
        cell.locationLabel.text = restaurantInfo.restaurants[indexPath.row].location
        cell.typeLabel.text = restaurantInfo.restaurants[indexPath.row].type
        cell.heartImage.isHidden = restaurantInfo.restaurants[indexPath.row].isHidden
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let  indexPath = tableView.indexPathForSelectedRow {
//                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                let rdvc = segue.destination as! RestaurantDetailViewController
//                print(cell.imageName)
//                rdvc.restaurantName = cell.imageName
//                rdvc.name = cell.nameLabel.text ?? ""
//                rdvc.type = cell.typeLabel.text ?? ""
//                rdvc.location = cell.locationLabel.text ?? ""
                
                rdvc.restaurant = restaurantInfo.restaurants[indexPath.row]
            }
        }
    }
 
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
        
        let checkOrUneckAction = UIContextualAction(style: .normal, title: nil){
            (action,sourceView,completionHandler) -> Void in
            cell.heartImage.isHidden = !self.restaurantInfo.restaurants[indexPath.row].isHidden
            self.restaurantInfo.restaurants[indexPath.row].isHidden = !self.restaurantInfo.restaurants[indexPath.row].isHidden
            completionHandler(true)
        }
        checkOrUneckAction.backgroundColor = UIColor.red
        checkOrUneckAction.image = UIImage(named: self.restaurantInfo.restaurants[indexPath.row].isHidden ? "tick" : "undo")
        
        let configuration = UISwipeActionsConfiguration(actions: [checkOrUneckAction])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
//            (action,sourceView,completionHandler) -> Void in
//            self.restaurant.delete(index: indexPath.row)
////            self.tableView.deselectRow(at: indexPath, animated: true)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//            completionHandler(true)
//        }
//
//        let shareAction = UIContextualAction(style: .destructive, title: "Share"){
//            (action,sourceView,completionHandler) -> Void in
//            let text = "Just checkin at " + self.restaurant.restaurantNames[indexPath.row]
//            let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
//            self.present(activityController, animated: true, completion: nil)
//            completionHandler(true)
//        }
        
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        
        var sharedActivityItems:[Any] = []
        let text = "Just checkin at " + self.restaurantInfo.restaurants[indexPath.row].name
        sharedActivityItems.append(text)
        if let image = UIImage(named: self.restaurantInfo.restaurants[indexPath.row].image) {
            sharedActivityItems.append(image)
        }
        
        let configuration = getActionConfiguration(tableView: tableView, data: self.restaurantInfo, indexPath: indexPath,sharedActivityItems: sharedActivityItems)
        return configuration
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue){
//        dismiss(animated: true, completion: nil)
    }
    
 
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        
//    }

}
