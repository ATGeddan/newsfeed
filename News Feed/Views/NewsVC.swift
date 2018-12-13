//
//  newsVC.swift
//  News Feed
//
//  Created by Ahmed Eltabbal on 4/27/18.
//  Copyright © 2018 Ahmed Eltabbal. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

// CONSTANTS :
let MAIN_POST_URL = "http://jsonplaceholder.typicode.com/posts/"
let MAIN_USER_URL = "http://jsonplaceholder.typicode.com/users/"
// Variables :
var miniPosts = [MiniPostModel]() // Main array downloaded
var filteredPosts = [MiniPostModel]() // Shuffled array used in search bar
var filteredPosts1 = [MiniPostModel]() // Shuffled Array
var userNames = ["0","1","2","3","4","5","6","7","8","9"]

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var menuBar: UIView!
  @IBOutlet weak var menuLeading: NSLayoutConstraint!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SVProgressHUD.show()
    getUsers(url: MAIN_USER_URL)
    getPosts(url: MAIN_POST_URL)
    tableView.delegate = self
    tableView.dataSource = self
    searchBar.delegate = self
    
    
    menuBar.layer.cornerRadius = 15
    menuBar.layer.shadowColor = UIColor.black.cgColor
    menuBar.layer.shadowOpacity = 0.8
    menuBar.layer.shadowOffset = CGSize(width: 5, height: 0)
    
    
  }
  
  
  
  func getPosts(url:String){
    Alamofire.request("\(url)").responseJSON {
      response in
      let jsonArray = response.result
      if jsonArray.isSuccess {
        
        guard let list = jsonArray.value as? [Dictionary<String,AnyObject>] else {return}
        for x in 0...list.count {
          let newPostEntry = MiniPostModel(data: list[x])
          miniPosts.append(newPostEntry)
          
        }
        filteredPosts1 = miniPosts.shuffled()
        filteredPosts = filteredPosts1
        self.configureTableView()
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
        
      } else {
        print("Error \(response.result.error!)")
      }
      
    }
  }
  
  func getUsers(url:String){
    Alamofire.request("\(url)").responseJSON {[weak self]
      response in
      let jsonArray = response.result
      if jsonArray.isSuccess {
        let list2 = jsonArray.value as? [Dictionary<String,AnyObject>]
        for y in 0...9 {
          if let userName = list2![y]["username"] as? String {
            userNames[y] = userName
          }
        }
        self?.tableView.reloadData()
      } else {
        print("Error \(response.result.error!)")
      }
      
    }
  }
  
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredPosts.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "newsCellz", for: indexPath) as? newsCellz
    
    let selectedPOST = filteredPosts[indexPath.row]
    cell?.updateCell(postModel: selectedPOST)

    return cell!
    
    
  }
  func configureTableView() {
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 120.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let minipost = filteredPosts[indexPath.row]
    performSegue(withIdentifier: "toPost", sender: minipost)
    
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as? PostVC, let post = sender as? MiniPostModel {
      destination.miniPost = post
    }
    
    
  }
  
  
  @IBAction func menuBarPressed(_ sender: Any) {
    
    if self.menuLeading.constant != 0 {
      UIView.animate(withDuration: 0.5) {[weak self] in
        self?.menuLeading.constant = 0
        self?.tableView.alpha = 0.5
        self?.view.layoutIfNeeded()
      }
      
      
      
    } else {
      UIView.animate(withDuration: 0.5) {[weak self] in
        self?.menuLeading.constant = -153
        self?.tableView.alpha = 1
        self?.view.layoutIfNeeded()
      }
      
    }
  }
  
  @IBAction func panGest(_ sender: UIPanGestureRecognizer) {
    if sender.state == .began || sender.state == .changed {
      let translation = sender.translation(in: self.view).x
      if translation > 20 { // Swipe right
        UIView.animate(withDuration: 0.3) {[weak self] in
          self?.menuLeading.constant = 0
          self?.tableView.alpha = 0.5
          self?.view.layoutIfNeeded()
        }
      } else if translation < -20 { // Swipe left
        UIView.animate(withDuration: 0.3) {[weak self] in
          self?.menuLeading.constant = -153
          self?.tableView.alpha = 1
          self?.view.layoutIfNeeded()
        }
      }
      
      
    }
    
  }
  // Search bar stuff
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var topofTable: NSLayoutConstraint!
  
  @IBAction func searchBtn(_ sender: UIBarButtonItem) {
    if topofTable.constant == CGFloat(0) {
      UIView.animate(withDuration: 0.3) {[weak self] in
        self?.topofTable.constant = 56
        self?.view.layoutIfNeeded()
      }
    } else {
      UIView.animate(withDuration: 0.3) {[weak self] in
        self?.topofTable.constant = 0
        self?.view.layoutIfNeeded()
      }
      
    }
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard !searchText.isEmpty else {
      filteredPosts = filteredPosts1
      tableView.reloadData()
      return
    }
    filteredPosts = filteredPosts1.filter({$0.modelPostTitle.lowercased().contains(searchText.lowercased())})
    tableView.reloadData()
  }
  
  
  
  
}

