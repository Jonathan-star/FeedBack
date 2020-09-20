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
    var questionTitleLabel: UILabel!
    var detailQuestion: UITextField!
    var detail: UILabel!
    var comment: UITableView!
    
    
//    var testText: UITextView!
//    var wjlLabel: UILabel!
//    var wjlButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        setUp()
//        loadData()
        
        
        
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
        loadQuestionData { (data) in
            for item in self.questions {
                if item.id == self.questionID {
                    self.questionOfthisPage = item
                    break
                } else {
                    print("nothing")
                }
            }
            print(self.questionOfthisPage as Any)
            self.questionTitleLabel = UILabel()
            self.questionTitleLabel.text = self.questionOfthisPage?.name
            self.questionTitleLabel.textColor = .black
            self.view.addSubview(self.questionTitleLabel)
            self.questionTitleLabel.snp.makeConstraints{ (make) in
                
                make.topMargin.equalTo(self.view.snp_topMargin).offset(30)
                make.leftMargin.equalTo(self.view.snp_leftMargin).offset(20)
            
            }
            self.questionTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
            

            self.detail = UILabel()
            self.detail.text = self.questionOfthisPage?.description
            self.detail.textColor = UIColor.black
            self.detail.backgroundColor = .clear
            self.detail.textAlignment = .left
            self.detail.numberOfLines = 0
            self.view.addSubview(self.detail)
            self.detail.snp.makeConstraints{ (make) in
                make.left.equalTo(15)
                make.right.equalTo(-15)
                make.top.equalTo(self.questionTitleLabel.snp.bottom).offset(5)
                make.height.greaterThanOrEqualTo(20)
            }
            self.detail.font = UIFont.boldSystemFont(ofSize: 15)
            
            
            
            
            
            
        }
        loadCommentData{(data) in
            
//            for item in self
            
            
            self.comment = UITableView()
            self.comment.backgroundColor = UIColor.white
            self.comment.delegate = self
            self.comment.dataSource = self
            self.view.addSubview(self.comment)
            self.comment.snp.makeConstraints{(make) in
                
                make.topMargin.equalTo(self.view.snp_top).offset(400)
                make.width.equalTo(self.view.frame.width)
            }
            
        }
        
    

        
        
        navigationItem.title = "问题详情"
        view.backgroundColor = UIColor.white
        

    }
    @objc func campusComfirm() {
        
    }
}

// MARK: - Data
extension FeedBackDetailViewController {
    private func loadCommentData(completion: @escaping ([CommentDatum])->Void) {
        CommentHelper.commentGet { (data) in
            self.comments = data
            completion(data)
        }
        
    }
    private func loadQuestionData(completion: @escaping ([QuestionDatum]) -> Void) {
        QuestionHelper.questionGet{ (data) in
            self.questions = data
            completion(data)
        }
    }
}

// MARK: - func

extension FeedBackDetailViewController: UITextViewDelegate,UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let commentCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "commentCellID")
        let commentCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "commentCellID")
        
        commentCell.backgroundColor = UIColor.lightGray
        commentCell.translatesAutoresizingMaskIntoConstraints = false
        commentCell.textLabel?.text = comments[indexPath.row].contain
        commentCell.textLabel?.textColor = .black
        commentCell.textLabel?.font = .boldSystemFont(ofSize: 18)
        commentCell.textLabel?.numberOfLines = 0
        commentCell.addSubview(commentCell.contentView)
        return commentCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
