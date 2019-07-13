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
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
//        
//        let optionMenu = UIAlertController(title: nil , message: "What do you want to do ?", preferredStyle: .alert)
//        
////        let callActionHandler = { (action:UIAlertAction!) -> Void in
////            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
////            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////            self.present(alertMessage, animated: true, completion: nil)
////        }
//        
//        let callActionHandler = { (action:UIAlertAction!) -> Void in
////            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
////            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////            self.present(alertMessage, animated: true, completion: nil)
//            if let url = URL(string: "tel:153-1391-221\(indexPath.row)"){
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }else{
//                    print("无法拨打电话")
//                }
//            }
//        }
//        
//        let checkInAction = UIAlertAction(title: self.restaurantIsHidden[indexPath.row] ? "Check in" : "Undo Check in", style: .default, handler: {
//            (action:UIAlertAction!) -> Void in
//            
//            cell.heartImage.isHidden = !self.restaurantIsHidden[indexPath.row]
//            self.restaurantIsHidden[indexPath.row] = !self.restaurantIsHidden[indexPath.row]
//            
//        })
//        
//        let callAction = UIAlertAction(title: "打电话给 "+"153-1391-221\(indexPath.row)", style: .default, handler: callActionHandler)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        optionMenu.addAction(checkInAction)
//        optionMenu.addAction(callAction)
//        present(optionMenu, animated: true, completion: nil)
//
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            restaurant.delete(index: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
////            tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    
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


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }

}
