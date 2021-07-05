//
//  riddleAddedSuccessViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 7/2/21.
//

import UIKit

class riddleAddedSuccessViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "UITabBarController")
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
    }
    
}
