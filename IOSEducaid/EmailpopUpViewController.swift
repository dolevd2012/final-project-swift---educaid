//
//  EmailpopUpViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/10/21.
//

import UIKit
//MARK: this popup opens when user in register try to siqn up with an email that already exists in the FB
class EmailpopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    


    @IBAction func okButtonClicked(_ sender: Any) {
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: "RegisterPAgeViewController")as! RegisterPAgeViewController
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
}
