//
//  RestaurantDetailViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/7.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
//    @IBOutlet var restaurantImageView:UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView:RestaurantDetailHeaderView!
    
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var typeLabel: UILabel!
//    @IBOutlet weak var locationLabel: UILabel!

    lazy var restaurant:Restaurant = Restaurant()
//    var name = ""
//    var type = ""
//    var location = ""
//    var restaurantName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.tintColor = .white
//        tableView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.tintColor = .white
//
        tableView.contentInsetAdjustmentBehavior = .never
        
        // Do any additional setup after loading the view.
        
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.heartImageView.isHidden = restaurant.isHidden
        
//        restaurantImageView.image = UIImage(named: resturant.image)
//        nameLabel.text = resturant.name
//        typeLabel.text = resturant.type
//        locationLabel.text = resturant.location
    
        navigationItem.largeTitleDisplayMode = .never
        tableView.separatorStyle = .none
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
            cell.imageView?.image = UIImage(named: "phone")
            cell.shortTextLabel?.text = restaurant.phone
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
            cell.imageView?.image = UIImage(named: "map")
            cell.shortTextLabel.text = restaurant.location
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel?.text = restaurant.description
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
