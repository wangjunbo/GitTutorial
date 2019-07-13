//
//  ViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/5/22.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
         print("viewDidLoad")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    @IBAction func showMessage1(sender:UIButton){
        let text = sender.titleLabel?.text
        let alertController = UIAlertController(title: "Welome to my first App", message: text, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }


}

