import Foundation
//Mark:Entity-BWFEntity
struct BWFEntity:Codable {
    let name:String
    let earnings:String
    let loss:String
    let points:String
    let rank:Int
    let ranking_changes:Int
    let tmntsPlayed:Int
    let win:Int
}
