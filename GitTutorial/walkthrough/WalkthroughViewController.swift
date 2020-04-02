//
//  WalkthroughViewController.swift
//  GitTutorial
//
//  Created by wangjunbo on 2019/9/1.
//  Copyright © 2019 wangjunbo. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController,WalkthroughPageViewControllerDelegate {
    
    let pageCount = Walkthrough.pageImages.count

    @IBOutlet var pageControl:UIPageControl!
    
    @IBOutlet var nextButton:MyButton!
    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    @IBOutlet var skipButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = Walkthrough.pageImages.count
    }
    
    @IBAction func skipButtonTapped(sender:UIButton){
        UserDefaults.standard.set(true, forKey: Walkthrough.hasViewedWalkthrough)
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageviewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageviewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    @IBAction func nextButtonTapped(sender:UIButton){

        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
                case 0...( pageCount - 2):
                    walkthroughPageViewController?.forwardPage()
                case pageCount - 1 :
                    skipButtonTapped(sender: UIButton())
                default:
                    break
            }
        }
        
        updateUI()
    }
    
    func updateUI(){
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
                case 0...( pageCount - 2):
                    nextButton.setTitle("NEXT", for: .normal)
                    skipButton.isHidden = false
                case pageCount - 1 :
                    nextButton.setTitle("GET STARTED", for: .normal)
                    skipButton.isHidden = true
                default:
                    break
            }
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
}
