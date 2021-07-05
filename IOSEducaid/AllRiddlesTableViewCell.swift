//
//  AllRiddlesTableViewCell.swift
//  IOSEducaid
//
//  Created by user196688 on 7/4/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AllRiddlesTableViewCell: UITableViewCell {

    @IBOutlet weak var userQuestion: UILabel!
    @IBOutlet weak var myAnswer: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var apply: UIButton!
    weak var delegate: AllRiddlesCellUpdater?

    var points = 10
    var index: Int = 0

    @IBAction func applyButtonClicked(_ sender: Any) {
        if(myAnswer.text == otherAnswers[index]){
            print("Correct answer You got \(points) points!")
            otherQuestions.remove(at: index)
            otherAnswers.remove(at: index)
            
            
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            
            ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              let value = snapshot.value as? NSDictionary
                var score = value?["score"] as? Int ?? -1
                var riddlesSolved = value?["riddlesSolved"] as? Int ?? -1
                score = score + self.points
                riddlesSolved = riddlesSolved + 1
                ref.child("users").child(userID!).child("score").setValue(score)
                ref.child("users").child(userID!).child("riddlesSolved").setValue(riddlesSolved)
                print("new score of the user is \(score)")
              // ...
              }) { (error) in
                print(error.localizedDescription)
            }
                
            
            delegate?.updateTableView()
        }
        else{
        if(points > 0){
            points = points - 1
            print("Wrong user ! -1 point (\(points) available)")}
        }
    }
}

//MARK: reloading tableviewController data from the cell TrashButton Click Action
protocol AllRiddlesCellUpdater: AllRiddlesViewController { // the name of the protocol you can put any
    func updateTableView()
}
