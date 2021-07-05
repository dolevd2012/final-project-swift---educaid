//
//  WrongLoginInfopopUpViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/10/21.
//

import UIKit

class WrongLoginInfopopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func okButtonClicked(_ sender: Any) {
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "LoginPageViewController")as! LoginPageViewController
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
}
