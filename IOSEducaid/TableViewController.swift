//
//  TableViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 6/11/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
var questions: [String] = [""]
var answers: [String] = [""]

class TableViewController: UIViewController, CustomCellUpdater {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("First Time in myRiddles")
        getUserRiddles()
        tableView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.tableView.reloadData()
            
        })
    }
    
    func getUserRiddles(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        questions = [""]
        answers = [""]
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let myRiddlesQ = value?["riddlesQuestion"]as! NSArray as! [String]
            for question in myRiddlesQ {
                if(question != ""){
                    questions.append(question)}
            }
            let myRiddlesA = value?["riddlesAnswer"]as! NSArray as! [String]
            for answer in myRiddlesA {
                if(answer != ""){
                    answers.append(answer)}
            }
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        
    }

}
extension TableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)as! TableViewCell
        cell.delegate = self
        if(indexPath.row == 0){
            cell.riddle.text = "riddle"
            cell.riddleAnswer.text = "riddle answer"
            cell.trashButton.isHidden = true
            return cell
        }
        else{
            cell.rowIndex = indexPath.row
            cell.riddle.text = questions[indexPath.row]
            cell.riddleAnswer.text = answers[indexPath.row]
            return cell
        }
    }
    
    //MARK: reload data everytime user visits his home screen
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
        print("reloading my riddles")
        self.tableView.reloadData()
        
    }
    func updateTableView() {
        self.tableView.reloadData()
        
    }
    
}
