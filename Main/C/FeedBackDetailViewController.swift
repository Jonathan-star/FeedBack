//
//  FeedBackDetailViewController.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import UIKit
import SnapKit
import Alamofire

class FeedBackDetailViewController: UIViewController {
    // MARK: - dataStorage
    
    var questionID: Int?
    var comments = [CommentDatum]()
    var questions = [QuestionDatum]()
    var questionOfthisPage: QuestionDatum?
    
    
    // MARK: - UIItems
    var titleLabel: UILabel!
    var detailQuestion: UITextView!
    var testText: UITextView!
    var wjlLabel: UILabel!
    var wjlButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setUp()
        laodData()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        setUp()
        
    }
}

// MARK: - UI
extension FeedBackDetailViewController {
    private func setUp() {
        
        print(questionID as Any)
        laodData()
        print(questions)
        
        
        for question in questions {
            if question.id == questionID {
                questionOfthisPage = question
                print(question.name as Any)
                return
            } else {
                print("nothing")
            }
        }
        
        
//        print(questionOfthisPage?.name)
        navigationItem.title = "问题详情"
        view.backgroundColor = UIColor.white
        
        wjlButton = UIButton()
        wjlButton.setImage(UIImage(systemName: "tortoise"), for: .normal)
//        wjlButton.contentVerticalAlignment = .fill
//        wjlButton.contentHorizontalAlignment = .fill
        wjlButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        wjlButton.tintColor = .systemBlue
        wjlButton.addTarget(self, action: #selector(campusComfirm), for: .touchUpInside)
        view.addSubview(wjlButton)
        wjlButton.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view.frame.width/2)
            make.centerY.equalTo(view.frame.height/2)
            make.height.equalTo(300)
            make.width.equalTo(300)
//            make.width.equalTo(view.frame.width * 1/3)
//            make.height.equalTo(view.frame.width * 1/3)
        }
        titleLabel = UILabel()
        titleLabel.text = questionOfthisPage?.name
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{ (make) in
            make.topMargin.equalTo(wjlButton.snp_bottom).offset(30)
            make.centerX.equalTo(view.frame.width/2)
        }
    }
    @objc func campusComfirm() {
        
    }
}

// MARK: - Data
extension FeedBackDetailViewController {
    private func laodData() {
        CommentHelper.commentGet { (data) in
            self.comments = data
        }
        QuestionHelper.questionGet{ (data) in
            self.questions = data
//            self.view.reloadInputViews()
        }
    }
}
