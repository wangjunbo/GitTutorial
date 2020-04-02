//
//  RestaurantTableViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/2.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit
import ContactsUI
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    
    //MARK: restaurant view controller
//    let restaurantInfo = RestaurantInfo()
    
    var appDelegate:AppDelegate!
    var managedObjectContext:NSManagedObjectContext!
    
    @IBOutlet var empytRestuarantView: UIView!
    
    var restaurants: [RestaurantMO] = []

    private let contactPicker = CNContactPickerViewController()
    
    var fetchResultController:NSFetchedResultsController<RestaurantMO>!
    
    var searchController:UISearchController!
    
    var searchResults:[RestaurantMO] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedObjectContext = getContext()
        
        do{
            let request: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            try fetchResultController.performFetch()
            if let fetchedObjects = fetchResultController.fetchedObjects {
                restaurants = fetchedObjects
            }

        }catch{
            print(error)
        }

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
        
        tableView.backgroundView = empytRestuarantView
        tableView.backgroundView?.isHidden = true
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
//        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
//        searchController.searchBar.prompt = "请输入"
//        searchController.searchBar.placeholder = "邀请函"
//        searchController.searchBar.backgroundImage = UIImage()
//        searchController.searchBar.barTintColor = .orange
//        searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60, alpha: 0.5)
        

      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: Walkthrough.hasViewedWalkthrough) {
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
                present(walkthroughViewController, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if restaurants.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        }else{
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        }
        return restaurants.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell1", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant =  searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel?.text = restaurant.name

        if let restaurantImage = restaurant.image {
            cell.thumbnailImageView.image = UIImage(data: restaurantImage)
        }

        cell.imageName = restaurant.name!
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.heartImage.isHidden = restaurant.isVisited
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let  indexPath = tableView.indexPathForSelectedRow {
//                let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
                let rdvc = segue.destination as! RestaurantDetailViewController
                
                rdvc.restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
 
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
        
        let checkOrUneckAction = UIContextualAction(style: .normal, title: nil){
            (action,sourceView,completionHandler) -> Void in
            cell.heartImage.isHidden = !self.restaurants[indexPath.row].isVisited
            self.restaurants[indexPath.row].isVisited = !self.restaurants[indexPath.row].isVisited
            completionHandler(true)
        }
        checkOrUneckAction.backgroundColor = UIColor.red
        checkOrUneckAction.image = UIImage(named: self.restaurants[indexPath.row].isVisited ? "tick" : "undo")
        
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
        let text = self.restaurants[indexPath.row].name!
        sharedActivityItems.append(text)
        if let image = UIImage(data: self.restaurants[indexPath.row].image!) {
            sharedActivityItems.append(image)
        }
        
        let restaurant = fetchResultController.object(at: indexPath)
        
        let configuration = getActionConfiguration(tableView: tableView, data: restaurant ,sharedActivityItems: sharedActivityItems)
        return configuration
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    @IBAction func unwindToHome(segue:UIStoryboardSegue){
//        dismiss(animated: true, completion: nil)
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at:[indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            print("do nothing")
        }
        
        if let fetchedObjects = controller.fetchedObjects
        {
            restaurants = fetchedObjects as!  [RestaurantMO]
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func filterContent(for searchText :String){
        searchResults = restaurants.filter( { (restaurant) -> Bool in
            
            if let name = restaurant.name {
                var isMatch = name.localizedStandardContains(searchText)
                
                if !isMatch {
                    if let location = restaurant.location {
                        var isMatch = location.localizedStandardContains(searchText)
                        return isMatch
                    }
                }
            }
            
            return false
            
        } )
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        }else {
            return true
        }
    }
}
