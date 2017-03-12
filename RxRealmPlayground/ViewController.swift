//
//  ViewController.swift
//  RxRealmPlayground
//
//  Created by kevin on 2017. 3. 10..
//  Copyright © 2017년 kevin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import Realm
import RealmSwift
import RxDataSources

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        let users = Observable.collection(from: realm.objects(User.self))
        
        users.bindTo(tableView.rx.items(cellIdentifier: "Cell")) { idx, user, cell in
            cell.textLabel?.text = user.firstName + " " + user.lastName
            cell.detailTextLabel?.text = user.nickName
        }.addDisposableTo(disposeBag)
        
//        let realm = try! Realm()
//        
//        let strings = realm.objects(StringStore.self)
//        Observable.collection(from: strings)
//            .bindNext({ [weak self] strings in
//                print("없겠지?")
//                guard let s = self else { return }
//                s.label.text = strings.toArray().last?.text
//            })
//            .addDisposableTo(disposeBag)
    }

}
