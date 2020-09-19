//
//  CommentHelper.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/18.
//

import Foundation
import Alamofire




struct CommentGet: Codable {
    var ErroeCode: Int?
    var msg: String?
    var data: [CommentDatum]?
}

struct CommentDatum:Codable {
    var id, user_id, likes: Int?
    var contain, created_at, updated_at: String?
}


class CommentHelper {
    
    
    static func commentGet(someClosure: @escaping ([CommentDatum]) -> Void) {
        
        let commentRequest: DataRequest = Alamofire.request(BASE_USER_URL + USER_COMMENT + "question_id=2")
        commentRequest.responseJSON { response in
            do {
                var commentArray: [CommentDatum] = []
                
                
                if let data = response.data {
                    
                    let commentGet = try JSONDecoder().decode(CommentGet.self, from: data)
                    for items in commentGet.data ?? [] {
                        
                        commentArray.append(items)
                    }
                    
                    someClosure(commentArray)
                }
                
            } catch {
                print("error")
            }
        }
    }
}
 
