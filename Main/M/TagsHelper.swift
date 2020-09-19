//
//  TagsHelper.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import Foundation
import Alamofire

// MARK: - TagsGet
struct TagsGet: Codable {
    var errorCode: Int?
    var msg: String?
    var data: [TagDatum]?
}

// MARK: - Datum
struct TagDatum: Codable {
    var id: Int?
    var name: String?
    var children: [TagDatum]?
}


struct Transaction: Codable {
    let amount: Int
    let recipient: String
    let sender: String
}


//var tags = [String]()
//var contentArray  = [[], ["教室","宿舍","食堂"]]


//escaping closure
class TagsHelper {
    
    static func tagGet(someClosure: @escaping ([[String]]) -> Void) {
        let tagRequest: DataRequest = Alamofire.request("http://47.93.253.240:10805/api/user/tag/get/all")
        tagRequest.validate().responseJSON{ response in
            do {
                var contentArray: [[String]] = [[], []]
                
                if let data = response.data {
                    let tagGet = try JSONDecoder().decode(TagsGet.self, from: data)
                    contentTags.removeAll()
//                    contentArray[0].removeAll()
                    for items in tagGet.data ?? [] {
                        contentTags.append(items.name ?? "")
                        contentArray[0].append(items.name ?? "")
                    }
                }
                someClosure(contentArray)
                print(contentTags)
                print(contentArray)
            } catch {
                print("error")
            }
        }
    }
}
