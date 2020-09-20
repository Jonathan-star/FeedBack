//
//  FeedBackMainViewController.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import UIKit
import SnapKit

let SCREEN = UIScreen.main.bounds

class FeedBackMainViewController: UIViewController, CBGroupAndStreamViewDelegate {
    // UI
//    var addButton: UIButton!
//    var searchButton: UIButton!
    var pyyButton: UIButton!
    var wjlButton: UIButton!
    var pyyLabel: UILabel!
    var wjlLabel: UILabel!
    var tagFilterPusher: UIButton!
    
    var addFeedBackBarButton: UIBarButtonItem!
    var searchBarButton: UIBarButtonItem!
    //    var collectionView: UIView!
    //    var collectionViewLayout!
    
    var filterView: CBGroupAndStreamView!
    
    var quetionTableView: UITableView! // 问题cell
    
    var replyScrollView: UIScrollView!// 显示最新回复
    
    // Data
    
    //    MARK: closure arrays
    
    var contentArray = [[String]]()
    var questions = [QuestionDatum]()
    
    var showFilter: Bool = false {
        didSet {
            if (showFilter) {
                tagFilterPusher.setTitle("保存tag", for: .normal)
                view.addSubview(filterView)
                filterView.snp.makeConstraints{ (make) in
                    make.topMargin.equalTo(tagFilterPusher.snp_bottom).offset(50)
                    make.width.equalTo(SCREEN.width)
                    make.height.equalTo(300)
                    make.centerX.equalTo(SCREEN.width/2)
                }
            } else {
                tagFilterPusher.setTitle("选择tag", for: .normal)
                filterView.removeFromSuperview()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         tableView = UICollectionView()
        //        tableView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
    
        loadData()
//        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setUp()
    
//        loadData()
    }
}


// MARK: - UI
extension FeedBackMainViewController {
    private func setUp() {
        
        addFeedBackBarButton = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(addToggle))
        addFeedBackBarButton.tintColor = .black
        searchBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchToggle))
        searchBarButton.tintColor = .black
        
        // navigationBar
//        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationItem.title = "Feed Back"
        self.navigationItem.rightBarButtonItems = [searchBarButton, addFeedBackBarButton]
        
        
        // MARK: Campus button & label
        pyyButton = UIButton()
        pyyButton.setImage(UIImage(systemName: "hare"), for: .normal)
        
        pyyButton.setTitle("北洋园", for: .normal)
        pyyButton.setTitleColor(.black, for: .normal)
        
        pyyButton?.contentVerticalAlignment = .fill
        pyyButton?.contentHorizontalAlignment = .fill
        pyyButton?.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        pyyButton?.tintColor = .systemBlue
        pyyButton.addTarget(self, action: #selector(campusComfirm), for: .touchUpInside)
        view.addSubview(pyyButton)
        pyyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(SCREEN.width * 1/4)
            make.centerY.equalTo(SCREEN.height * 1/4)
            make.width.height.equalTo(SCREEN.width * 1/3)
        }
//        pyyButton.setLayoutType(type: .topImage)
//        pyyButton.imageView?.sizeToFit()
        
        pyyLabel = UILabel()
        pyyLabel.text = "北洋园的反馈"
        pyyLabel.tintColor = .systemBlue
        pyyLabel.textColor = .black
        view.addSubview(pyyLabel)
        pyyLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(view.frame.width/4)
            make.topMargin.equalTo(pyyButton.snp_bottom).offset(-5)
        }
        // FIXME: 改写成
        wjlButton = UIButton()
        wjlButton.setImage(UIImage(systemName: "tortoise"), for: .normal)
        wjlButton.contentVerticalAlignment = .fill
        wjlButton.contentHorizontalAlignment = .fill
        wjlButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        wjlButton.tintColor = .systemBlue
        wjlButton.addTarget(self, action: #selector(campusComfirm), for: .touchUpInside)
        view.addSubview(wjlButton)
        wjlButton.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view.frame.width * 3/4)
            make.centerY.equalTo(view.frame.height * 1/4)
            make.width.equalTo(view.frame.width * 1/3)
            make.height.equalTo(view.frame.width * 1/3)
        }
        
        wjlLabel = UILabel()
        wjlLabel.text = "卫津路的反馈"
        wjlLabel.tintColor = .black
        wjlLabel.textColor = .black
        view.addSubview(wjlLabel)
        wjlLabel.snp.makeConstraints{(make) in
            make.centerX.equalTo(view.frame.width * 3/4)
            make.topMargin.equalTo(wjlButton.snp_bottom).offset(-5)
        }
        
        tagFilterPusher = UIButton()
        tagFilterPusher.backgroundColor = .systemBlue
        tagFilterPusher.setTitle("选择tag", for: .normal)
        tagFilterPusher.addTarget(self, action: #selector(filterPusher), for: .touchUpInside)
        tagFilterPusher.layer.cornerRadius = 10
        view.addSubview(tagFilterPusher)
        tagFilterPusher.snp.makeConstraints{ (make) in
            make.centerX.equalTo(view.frame.width/2)
            make.top.equalTo(wjlLabel.snp_bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        filterView = CBGroupAndStreamView.init(frame: CGRect(x: 0, y: 400, width: self.view.frame.width, height: 200))
        filterView.titleTextFont = .systemFont(ofSize: 14)
        filterView.titleLabHeight = 30
        filterView.titleTextColor = .red
        filterView.isSingle = false
        filterView.defaultSelIndexArr = [0,0]
        filterView.defaultGroupSingleArr = [1,1]
        filterView.delegate = self
        
        
        
        quetionTableView = UITableView()
        quetionTableView.backgroundColor = UIColor.gray
        quetionTableView.delegate = self
        quetionTableView.dataSource = self
        self.view.addSubview(quetionTableView)
        quetionTableView.snp.makeConstraints{(make) in
            //            make.topMargin.equalTo(500)
            make.width.equalTo(view.frame.width)
            //            make.height.equalTo(300)
            make.top.equalTo(tagFilterPusher.snp_bottom).offset(100)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

// MARK: - TableView Delegate
extension FeedBackMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let questionCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cellID")
        questionCell.reloadInputViews()
        questionCell.translatesAutoresizingMaskIntoConstraints = false
        questionCell.textLabel?.text = questions[indexPath.row].name
        questionCell.textLabel?.textColor = .black
        
        questionCell.backgroundColor = .white
        questionCell.textLabel?.font = .boldSystemFont(ofSize: 18)
        questionCell.textLabel?.textColor = .black
        questionCell.backgroundColor = UIColor.white
        questionCell.textLabel?.numberOfLines = 0
        questionCell.addSubview(questionCell.contentView)
        questionCell.detailTextLabel?.text = questions[indexPath.row].description
        questionCell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        questionCell.detailTextLabel?.font = .boldSystemFont(ofSize: 12)
        questionCell.detailTextLabel?.textColor = .darkGray
        questionCell.detailTextLabel?.snp.makeConstraints {(make) in
            make.top.equalTo((questionCell.textLabel?.snp.bottom)!).offset(10)
            make.left.equalTo((questionCell.textLabel?.snp.left)!)
        }
        return questionCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = FeedBackDetailViewController()
        
        if questions[indexPath.row].id != nil {
            VC.questionID = questions[indexPath.row].id
            
//            print(questions[indexPath.row].id)
        } else {
            print("no id")
            
        }
//        self.performSegue(withIdentifier: "ShowDetailView", sender: VC.questionID)
//        VC.questionID = questions[indexPath.row].id
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowDetailView"{
//                let controller = segue.destination as! FeedBackDetailViewController
//                controller.questionID = sender as? Int
//            }
//        }
}

// MARK: - Data Control
extension FeedBackMainViewController {
    private func loadData() {
        TagsHelper.tagGet { (data) in
            self.contentArray = data
            self.filterView.setDataSource(contentArr: self.contentArray, titleArr: titleArr)
            self.filterView.reload()
        }
        
        
        QuestionHelper.questionGet{ (data) in
            self.questions = data
            self.quetionTableView.reloadData()
        }
    }
}

// MARK: - Button Methods
extension FeedBackMainViewController {
    @objc func addToggle() {
        let addVC = NewFeedBackViewController()
        self.present(addVC, animated: true, completion: nil)
    }
    
    @objc func searchToggle() {
        let searchVC = FeedBackSearchViewController()
        self.present(searchVC, animated: true, completion: nil)
    }
    
    @objc func filterPusher() {
        TagsHelper.tagGet { (data) in
            self.contentArray = data
        }
        filterView.reload()
        showFilter.toggle()
        
        print(questions.count)
        print(questions)
    }
    
    @objc func campusComfirm() {
        
    }
}

