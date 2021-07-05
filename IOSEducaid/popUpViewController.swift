//
//  popUpViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/8/21.
//

import UIKit

var cameFromController : String?
//MARK:

class popUpViewController: UIViewController {
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        cameFromController = UserDefaults.standard.string(forKey: "controllerCalledPopup")
    }


    @IBAction func OkButtonClicked(_ sender: Any) {
        let popOutStory = UIStoryboard(name: "Main", bundle: nil)
        let controller = popOutStory.instantiateViewController(identifier: cameFromController!)
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    
}
