//
//  User.swift
//  RxRealmPlayground
//
//  Created by kevin on 2017. 3. 11..
//  Copyright © 2017년 kevin. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var nickName: String?
}
