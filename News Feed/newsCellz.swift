//
//  newsCell.swift
//  News Feed
//
//  Created by Ahmed Eltabbal on 4/27/18.
//  Copyright © 2018 Ahmed Eltabbal. All rights reserved.
//

import UIKit

class newsCellz: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    
    func updateCell(postModel : MiniPostModel) {
      cellTitle.text = "\(postModel.modelPostTitle)...Read more."
      let ID = postModel.modelAccID
      userNameLbl.text = userNames[ID - 1]
      cellImage.image = UIImage(named: "cat\(ID - 1)")
      cellImage.layer.cornerRadius = cellImage.frame.size.width / 2
      cellImage.layer.borderWidth = 3.0
      cellImage.layer.borderColor = UIColor.darkGray.cgColor
      cellView.layer.cornerRadius = 15

    }


}
