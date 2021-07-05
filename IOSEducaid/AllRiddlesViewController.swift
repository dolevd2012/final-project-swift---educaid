//
//  AllRiddlesViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 7/4/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

var otherQuestions: [String] = []
var otherAnswers: [String] = []
var otherUid : [String] = []
class AllRiddlesViewController: UIViewController,AllRiddlesCellUpdater {

    @IBOutlet weak var allRiddlesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllOtherUsersRiddles()

        allRiddlesTableView.dataSource = self
    }
    
}
//MARK: get all useres from scoreboard with each score
func getAllOtherUsersRiddles(){
    let myUserID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    ref = Database.database().reference()
    // Async reading from firebase
    otherAnswers = []
    otherQuestions = []
    ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
      // Get user value
      let value = snapshot.value as? NSDictionary
        let allUsers = value?.allKeys as! [String]
        for userUid in allUsers{
            if(userUid != myUserID){
                ref.child("users").child(userUid).observeSingleEvent(of: .value, with: { snapshot in
                    let value = snapshot.value as? NSDictionary
                    let RiddlesQ = value?["riddlesQuestion"]as! NSArray as! [String]
                    for question in RiddlesQ {
                        if(question != ""){
                            otherUid.append(userUid)
                            otherQuestions.append(question)}
                    }
                    let RiddlesA = value?["riddlesAnswer"]as! NSArray as! [String]
                    for answer in RiddlesA {
                        if(answer != ""){
                            otherAnswers.append(answer)}
                    }
              }) { error in
                 print(error.localizedDescription)
              }
            }
        }
      // ...
      }) { (error) in
        print(error.localizedDescription)
    }

}


extension AllRiddlesViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherQuestions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "riddleID", for: indexPath)as! AllRiddlesTableViewCell
        cell.userQuestion.text = otherQuestions[indexPath.row]
        cell.myAnswer.text = ""
        cell.index = indexPath.row
        let storageRef = Storage.storage().reference()
        cell.delegate = self
        // Create a reference to the file you want to download
        storageRef.child("images").child(otherUid[indexPath.row]).downloadURL { (url,err) in
            if err != nil
            {
                print((err?.localizedDescription)!)
                return
            }
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            cell.userImage.image = UIImage(data: data!)
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.allRiddlesTableView.reloadData()
        
    
        
    }
    func updateTableView() {
        self.allRiddlesTableView.reloadData()
        
    }
}
