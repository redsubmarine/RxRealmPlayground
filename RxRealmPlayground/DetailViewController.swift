//
//  DetailViewController.swift
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

class DetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(firstNameTextField.rx.text, lastNameTextField.rx.text, resultSelector: { fn, ln -> Bool in
            if let fn = fn, let ln = ln {
                return !fn.isEmpty && !ln.isEmpty
            }
            return false
        })
            .bindTo(saveButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
        
        saveButton.rx.tap
            .bindNext({ [weak self] in
                self?.saveToCurrentUser()
            })
            .addDisposableTo(disposeBag)
        
        firstNameTextField.rx.controlEvent(.editingChanged)
            .bindNext({ [weak self] _ in
                self?.user.firstName = self?.firstNameTextField.text ?? ""
            })
            .addDisposableTo(disposeBag)
        
        lastNameTextField.rx.controlEvent(.editingChanged)
            .bindNext({ [weak self] _ in
                self?.user.lastName = self?.lastNameTextField.text ?? ""
            })
            .addDisposableTo(disposeBag)
        
        nickNameTextField.rx.controlEvent(.editingChanged)
            .bindNext({ [weak self] _ in
                self?.user.nickName = self?.nickNameTextField.text ?? ""
            })
            .addDisposableTo(disposeBag)
    }
    
    func saveToCurrentUser() {
        Observable.from(object: user).subscribe(Realm.rx.add()).addDisposableTo(disposeBag)
        _ = navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("\(self) is being deinitialized.")
    }
    
}
