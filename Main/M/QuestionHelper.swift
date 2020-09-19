//
//  QuestionHelper.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import Foundation
import Alamofire


// MARK: - QuestionGet
struct QuestionGet: Codable {
    var ErrorCode: Int?
    var msg: String?
    var data: [QuestionDatum]?
}

// MARK: - QusetionDatum
struct QuestionDatum: Codable {
    var id: Int?
    var name, description: String?
    var user_id, solved, no_commit, likes: Int?
    var created_at, updated_at: String?
}

//  stupid quicktype QAQ

class QuestionHelper {
    static func questionGet(someClosure: @escaping ([QuestionDatum]) -> Void) {
        let questionRequest: DataRequest = Alamofire.request("http://47.93.253.240:10805/api/user/question/search")
        questionRequest.responseJSON(){ response in
            do {
                
                var questionArray: [QuestionDatum] = []
                
                if let data = response.data {
                    let questionGet = try JSONDecoder().decode(QuestionGet.self, from: data)
                    for items in questionGet.data ?? [] {
                        
                        questionArray.append(items)
                    }
                    
                    someClosure(questionArray)

                }
            } catch {
                print("error")
            }
        }
    }
}
