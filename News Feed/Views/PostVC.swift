//
//  PostVC.swift
//  News Feed
//
//  Created by Ahmed Eltabbal on 4/28/18.
//  Copyright © 2018 Ahmed Eltabbal. All rights reserved.
//

import UIKit
import Alamofire

class PostVC: UIViewController {
    @IBOutlet weak var postView2: UIView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postBody: UITextView!
    var postVCID:Int!
    var miniPost: MiniPostModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = miniPost.modelPostTitle
        postBody.text = miniPost.modelPostBody
        postVCID = miniPost.modelAccID
        getUser(id: postVCID)
        userImage.image = UIImage(named: "cat\(postVCID - 1)")
        userImage.layer.cornerRadius = (userImage.frame.size.width) / 2
        userImage.layer.borderWidth = 3.0
        userImage.layer.borderColor = UIColor.darkGray.cgColor
        postView.layer.cornerRadius = 15
        postView2.layer.cornerRadius = 15
        
        
    }
    
    func getUser(id:Int) {
        Alamofire.request("http://jsonplaceholder.typicode.com/users/\(id)").responseJSON {[weak self]
            response in
            let jsonArray = response.result
            if jsonArray.isSuccess {
              guard let list2 = jsonArray.value as? Dictionary<String,AnyObject> else {return}
                if let name = list2["name"] as? String, let userName = list2["username"] as? String,let email = list2["email"] as? String {
                    self?.nameLabel.text = name
                    self?.usernameLabel.text = userName
                    self?.emailLabel.text = email
                    self?.view.layoutIfNeeded()
                }
            } else {
                print("Error \(response.result.error!)")
            }
            
        }
    }



    



}
