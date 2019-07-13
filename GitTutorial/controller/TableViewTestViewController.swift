//
//  TableViewTestViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/1.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class TableViewTestViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var thaimthubs = ["Barrafina","Bourke","CASK","Cafe","Cafe","Cafe","Confessional","Donostia","Five","For","Graham","Haigh's","Homei","Palomino","Petite","Po's","Royal","Teakha","Traif","Upstate","Waffle"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: thaimthubs[indexPath.row])
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
