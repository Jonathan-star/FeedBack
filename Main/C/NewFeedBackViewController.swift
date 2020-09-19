//
//  NewFeedBackViewController.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import UIKit
import SnapKit
import Alamofire

class NewFeedBackViewController: UIViewController, UITextViewDelegate {
     
     var titleField: UITextField!
     var confirmButton: UIButton!
     var contentField: UITextView!
     
     var titleLabel: UILabel!
     var classLabel: UILabel!
     var contentsLabel: UILabel!
     
     
     
    override func viewDidLoad() {
          
        super.viewDidLoad()
        
          
          
        titleField = UITextField()
//        titleField = UITextField(frame: CGRect(x: 0, y: view.width/2, width: 200, height: 50))
          
        titleField?.placeholder = "10字以内"
        titleField.backgroundColor = .white
        titleField.textColor = .black
        titleField?.borderStyle = .roundedRect
        titleField.layer.cornerRadius = 5.0
        titleField.layer.borderColor = UIColor.gray.cgColor
        titleField.layer.borderWidth = 1.5
//        titleField?.layer.borderColor = UIColor.black.cgColor
          
        view.addSubview(titleField)
          
        titleField?.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view.bounds.width/2)
               make.height.equalTo(30)
               make.width.equalTo(250)
            make.centerY.equalTo(view.bounds.height/8)
          
        }
          
          
        titleLabel = UILabel()
          
        titleLabel.text = "标题："
        titleLabel.textColor = UIColor.black
          
        view.addSubview(titleLabel)
          
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalTo(view.bounds.height/8)
               make.right.equalTo(titleField.snp_left)
        }

          
        contentField = UITextView(/*frame: CGRect(x: 0, y: view.width/2 + 150 , width: 200, height: 200)*/)
          
        contentField.layer.borderWidth = 1.5
          
        contentField.delegate = self
        contentField.backgroundColor = .white
        contentField.textColor = .black
        contentField.layer.borderColor = UIColor.black.cgColor
          
        contentField.layer.borderWidth = 1.0
          
        contentField.layer.cornerRadius = 5.0
          
        view.addSubview(contentField)
          
        contentField.snp.makeConstraints{ (make) in
            
            make.centerX.equalTo(view.bounds.width/2)
//            make.centerY.equalTo(view.bounds.height/2 - 50)
            make.topMargin.equalTo(titleField.snp_bottom).offset(50)
               
            make.height.equalTo(300)
               
            make.width.equalTo(250)
          
        }
          
          
        
        contentsLabel = UILabel()
          
        contentsLabel.text = "正文："
        contentsLabel.textColor = UIColor.black
          
        view.addSubview(contentsLabel)
          
        contentsLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(contentField.snp_topMargin)
               
            make.right.equalTo(contentField.snp_left)
        }
          
          
        let newFeedBackView = view
          
        newFeedBackView?.backgroundColor = .white
          
          
          
        confirmButton = UIButton()
          
        confirmButton.backgroundColor = .systemBlue
          
        confirmButton.addTarget(self, action: #selector(test), for: .touchUpInside)
          
        confirmButton.setTitle("确认提交", for: .normal)
          
        confirmButton.layer.cornerRadius = 10
        
          
        view.addSubview(confirmButton)
          
        confirmButton.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(view.bounds.width/2)
//            make.centerY.equalTo(view.bounds.height * 3/4)
            make.topMargin.equalTo(contentField.snp_bottom).offset(50)
               
            make.height.equalTo(50)
               
            make.width.equalTo(200)
               
          
        }
        
        
          
//          let titleView = UITextView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.size.width, height: 60))
          
     }
     
     @objc func test() {
          print("1")
          
     }
     
     
    override func viewWillAppear(_ animated: Bool) {
          
        super .viewWillAppear(animated)
          
//          self.title = "新的反馈"
//          self.navigationItem.titleView = UILabel(text: "反馈信息")
//          self.navigationController?.setNavigationBarHidden(false, animated: animated)
//          self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: YellowPageMainViewController.mainColor), for: .default)
          
          
     }
//     MARK: restrict word counts
     
    override func viewDidAppear(_ animated: Bool) {
            //监听textField内容改变通知
            
        NotificationCenter.default.addObserver(self,
                selector: #selector(self.greetingTextFieldChanged),
                name:NSNotification.Name(rawValue:"UITextFieldTextDidChangeNotification"),
                object: self.titleField)
        
    }
     
     
//     TODO: 仿写这个到content上。
     
     //textField内容改变通知响应
     @objc func greetingTextFieldChanged(obj: Notification) {
         //非markedText才继续往下处理
         guard let _: UITextRange = titleField.markedTextRange else{
             //当前光标的位置（后面会对其做修改）
             let cursorPostion = titleField.offset(from: titleField.endOfDocument,
                                                  to: titleField.selectedTextRange!.end)
             //判断非中文的正则表达式
             let pattern = "[^\\u4E00-\\u9FA5]"
             //替换后的字符串（过滤调非中文字符）
             var str = titleField.text!.pregReplace(pattern: pattern, with: "")
             //如果长度超过限制则直接截断
             if str.count > 10 {
                 str = String(str.prefix(10))
             }
             titleField.text = str
              
             //让光标停留在正确位置
             let targetPostion = titleField.position(from: titleField.endOfDocument,
                                                    offset: cursorPostion)!
             titleField.selectedTextRange = titleField.textRange(from: targetPostion,
                                                               to: targetPostion)
             return
         }
     }
     override func viewDidDisappear(_ animated: Bool) {
         //移除textField内容改变通知监听
         NotificationCenter.default.removeObserver(self,
             name:NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"),
             object: self.titleField)
     }
      
     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
}

extension String {
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
}
