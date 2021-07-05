//
//  scoreBoardData.swift
//  IOSEducaid
//
//  Created by user196688 on 7/3/21.
//

import Foundation

//MARK: created just to make scoreboard top 3 users info loading easier 
class scoreBoardData{
    var uid: String
    var score:Int
    
    init(uid : String , score : Int) {
        self.uid = uid
        self.score = score
    }
    
    
}
