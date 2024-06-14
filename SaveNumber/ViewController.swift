//
//  ViewController.swift
//  SaveNumber
//
//  Created by Benjamin Wong on 2024/5/13.
//

import UIKit
import SwifterSwift
import ProgressHUD
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    Client.shared.currentUser.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] user in
      guard let self = self, let user = user else {
        return
      }
      self.nameLabel.text = user.name
      if let n = user.myNumber {
        self.textField.text = "\(n)"
      }
    }).disposed(by: disposeBag)
    textField.delegate = self
  }

  @IBAction func lgoinButtonPressed(_ sender: UIButton) {
    Client.shared.login(viewController: self)
  }
  
  @IBAction func saveNumberButtonPressed(_ sender: UIButton) {
    guard let text = textField.text else {
      return
    }
    ProgressHUD.show()
    Client.shared.saveNumber(number: text).observe(on: MainScheduler.instance).subscribe(onCompleted: { [weak self] in
      guard let self = self else {
        return
      }
      ProgressHUD.showSucceed()
    }, onError: { error in
      ProgressHUD.showError(error.localizedDescription)
    }).disposed(by: disposeBag)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.view.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
  }
}
