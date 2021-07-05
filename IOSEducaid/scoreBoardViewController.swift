//
//  scoreBoardViewController.swift
//  IOSEducaid
//
//  Created by user196688 on 7/3/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
class scoreBoardViewController: UIViewController {
    @IBOutlet weak var firstPlaceImage: UIImageView!
    @IBOutlet weak var secondPlaceImage: UIImageView!
    @IBOutlet weak var thirdPlaceImage: UIImageView!
    @IBOutlet weak var firstPlaceScore: UILabel!
    @IBOutlet weak var secondPlaceScore: UILabel!
    @IBOutlet weak var thirdPlaceScore: UILabel!
    var myData: [scoreBoardData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: get all useres from scoreboard with each score
    func getAllUserAndScores(){
        print("Getting all useres from the firebase")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        // Async reading from firebase
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            let allUsers = value?.allKeys as! [String]
            for userUid in allUsers{
                ref.child("users").child(userUid).observeSingleEvent(of: .value, with: { snapshot in
                  let value = snapshot.value as? NSDictionary
                  let score = value?["score"] as! Int
                  let scoreBoardDat = scoreBoardData.init(uid: userUid, score: score)
                  self.myData.append(scoreBoardDat)
                }) { error in
                  print(error.localizedDescription)
                }
            }
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        // make sure we managed to read the data before working on it, so i created delay of 1 seconds to make sure the app wont crash
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.sortScoreBoard()
            self.myData.removeAll()
        })

    }
    
    //MARK: sort the scoreboard and calls to the load function with the top 3 users to show in the view
    func sortScoreBoard(){
        let sorted = myData.sorted(by:{ $0.score > $1.score })
        loadUserScoreBoardPlacement(uid: sorted[0].uid,place: firstPlaceImage)
        loadUserScoreBoardPlacement(uid: sorted[1].uid,place: secondPlaceImage)
        loadUserScoreBoardPlacement(uid: sorted[2].uid,place: thirdPlaceImage)
        firstPlaceScore.text = "\(sorted[0].score) p"
        secondPlaceScore.text = "\(sorted[1].score) p"
        thirdPlaceScore.text = "\(sorted[2].score) p"
    }
    
    //MARK: loading specific user image and score to the view
    func loadUserScoreBoardPlacement(uid : String , place : UIImageView)
    {
        // Get a reference to the storage service using the default Firebase App
        let storageRef = Storage.storage().reference()
        var image : UIImage?
        // Create a reference to the file you want to download
        storageRef.child("images").child(uid).downloadURL { (url,err) in
            if err != nil
            {
                print((err?.localizedDescription)!)
                return
            }
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            image = UIImage(data: data!)
            place.image = image
        }

    }
    
    //MARK: reload data everytime user visits his home screen
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            print("reloading scoreBoard page")
            getAllUserAndScores()
    }

}
