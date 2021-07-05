//
//  TableViewCell.swift
//  IOSEducaid
//
//  Created by user196688 on 6/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TableViewCell: UITableViewCell {

    @IBOutlet weak var riddle: UILabel!
    @IBOutlet weak var riddleAnswer: UILabel!
    var rowIndex:Int = 0
    @IBOutlet weak var trashButton: UIButton!
    weak var delegate: CustomCellUpdater?
    
    
    
    @IBAction func trashButtonClicked(_ sender: UIButton) {
        print("Trash clicked")
        questions.remove(at: rowIndex)
        answers.remove(at: rowIndex)
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).child("riddlesQuestion").setValue(questions)
        ref.child("users").child(userID!).child("riddlesAnswer").setValue(answers)
        
        delegate?.updateTableView()
        
        }
    
}

//MARK: reloading tableviewController data from the cell TrashButton Click Action
protocol CustomCellUpdater: TableViewController { // the name of the protocol you can put any
    func updateTableView()
}
