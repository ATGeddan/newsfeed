//
//  minipostModel.swift
//  News Feed
//
//  Created by Ahmed Eltabbal on 4/27/18.
//  Copyright © 2018 Ahmed Eltabbal. All rights reserved.
//

import Foundation

class MiniPostModel {
  private var _modelAccID:Int = 0
  private var _modelPostTitle:String = ""
  private var _modelPostBody:String = ""
  
  var modelAccID:Int {
    return _modelAccID
  }
  var modelPostTitle:String {
    return _modelPostTitle
  }
  var modelPostBody:String {
    return _modelPostBody
  }
  
  init(data: [String:AnyObject]) {
    if let id = data["userId"] as? Int, let title = data["title"] as? String, let body = data["body"] as? String {
      _modelAccID = id
      _modelPostTitle = title
      _modelPostBody = body
    }
  }
}
