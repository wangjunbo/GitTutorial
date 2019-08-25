//
//  MyExtension.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/7/6.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import Foundation
import ContactsUI
import CoreData

extension CNContact {
    open func displayName() -> String {
        return givenName + " " + familyName
    }
}

protocol Object {
    func delete(index:Int)
}

extension UIViewController {
    
    func getAppDelegate() -> AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    
    func getContext() -> NSManagedObjectContext {
        return getAppDelegate().persistentContainer.viewContext
    }

    func getActionConfiguration(tableView:UITableView, data:[RestaurantMO], indexPath:IndexPath,sharedActivityItems:[Any]) -> UISwipeActionsConfiguration{
        let deleteAction = UIContextualAction(style: .destructive, title: "") {
            (action,sourceView,completionHandler) -> Void in
//            data.delete(index: indexPath.row)
//            data.remove(at: indexPath.row)
//            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: ""){
            (action,sourceView,completionHandler) -> Void in
            let activityController = UIActivityViewController(activityItems: sharedActivityItems, applicationActivities: nil)
            completionHandler(true)
            
            //for ipad
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
        }
        
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(named: "share")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        return configuration
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
