//
//  UsernameModel.swift
//  News Feed
//
//  Created by Ahmed Eltabbal on 4/28/18.
//  Copyright © 2018 Ahmed Eltabbal. All rights reserved.
//

import Foundation
import Alamofire

class UsernameModel {
    private var _username = ""
    private var _fullname = ""
    private var _email = ""
    
    var username:String {
        return _username
    }
    var fullname:String {
        return _fullname
    }
    var email:String {
        return _email
    }
    
    init(username:String,fullname:String,email:String) {
        _username = username
        _fullname = fullname
        _email = email
    }
    

    
}
