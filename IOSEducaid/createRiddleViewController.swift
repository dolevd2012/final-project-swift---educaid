//
//  createRiddleViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class createRiddleViewController: UIViewController {
    @IBOutlet weak var riddleQuestionTF: UITextField!
    @IBOutlet weak var riddleAnswerTF: UITextField!
    

    @IBOutlet weak var createRiddleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func createRiddleAction(_ sender: Any) {

        if(riddleQuestionTF.text == "" || riddleAnswerTF.text == ""){
            print("dont leave empty areas")
        }
        else{
            questions.append(riddleQuestionTF.text!)
            answers.append(riddleAnswerTF.text!)
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            ref.child("users").child(userID!).child("riddlesQuestion").setValue(questions)
            ref.child("users").child(userID!).child("riddlesAnswer").setValue(answers)
            
            let popOutStory = UIStoryboard(name: "Main", bundle: nil)
            let controller = popOutStory.instantiateViewController(identifier: "riddleAddedSuccessViewController")
            self.addChild(controller)
            controller.view.frame = self.view.frame
            self.view.addSubview(controller.view)
            controller.didMove(toParent: self)
            
            
            
        }
    }
    
    
}
