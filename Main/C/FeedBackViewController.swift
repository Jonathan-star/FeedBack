//
//  FeedBackViewController.swift
//  FeedBack
//
//  Created by 于隆祎 on 2020/9/17.
//

import UIKit

class FeedBackSearchViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var backGround: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        searchBar?.placeholder = "search something"
        searchBar?.enablesReturnKeyAutomatically = true
        searchBar.tintColor = .systemBlue
        searchBar.backgroundColor = .white
        searchBar.barTintColor = .white
        searchBar.delegate = self
        searchBar.barStyle = .black
        searchBar.layer.borderWidth = 1.5
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        searchBar?.snp.makeConstraints{(make) in
          make.centerX.equalTo(view.bounds.width/2)
             make.centerY.equalTo(50)
             make.left.equalTo(20)
//             make.height.equalTo(75)
        }
        let newFeedBackView = view
        newFeedBackView?.backgroundColor = .white
        
        
    }
}
extension FeedBackSearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要开始编辑")
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("已经开始编辑")
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("将要结束编辑")
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("已经结束编辑")
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("文本改变的时候触发 text: \(text)")
        return true
    }
    
    
}
