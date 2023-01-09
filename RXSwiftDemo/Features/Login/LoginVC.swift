//
//  LoginVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 07/01/2023.
//

import UIKit
import RxCocoa
import RxSwift
import JVFloatLabeledTextField

enum ButtonState {
    case play, pause
}

class LoginVC: UIViewController {
    @IBOutlet weak var emailTextField: JVFloatLabeledTextField!
    @IBOutlet weak var phoneNumberTF: CustomOutlinedTxtField!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var loginBtn: UIButton!
    
    var disposeBag = DisposeBag()
    let emailRelay = BehaviorRelay<String>(value: "")
    let phoneRelay = BehaviorRelay<String>(value: "")
    let viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    setupBindings()
        setupBindingsWithViewModel()
   
    }
    func setupBindingsWithViewModel() {
        emailTextField.rx.text.orEmpty.map{$0.count > 6}.bind(to: viewModel.emailBehaviourRelay).disposed(by: disposeBag)
        phoneNumberTF.textField.rx.text.orEmpty.map{$0.count > 6}.bind(to: viewModel.phoneBehaviourRelay).disposed(by: disposeBag)
      viewModel.isValidForm.drive(loginBtn.rx.isEnabled).disposed(by: disposeBag)
        loginBtn.rx.tap.subscribe { _ in
            self.loginTapped()
        }.disposed(by: disposeBag)

        viewModel.isLoadingBehaviourRelay.bind { isLoading in
            if isLoading {
               print("Loading.....")
            } else {
                print("stop loading")
            }
        }.disposed(by: disposeBag)
   
        
        
      //  emailBehavirRelay.bind(to: LoginViewModel.Input.e)
      //  let input = LoginViewModel.Input(emailBehaviourRelay: emailBehavirRelay, phoneBehaviourRelay: phoneBehavirRelay)
        

    }
    
    func setupBindings() {
        isValid.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        emailTextField.rx.text.orEmpty.bind(to: emailRelay).disposed(by: disposeBag)
        phoneNumberTF.textField.rx.text.orEmpty.bind(to: phoneRelay).disposed(by: disposeBag)
        loginBtn.rx.tap.bind{
            print("TAAAAped")
        }.disposed(by: disposeBag)
    
        switchButton.rx.value.changed.bind {(isOn) in
            print(isOn)
        }.disposed(by: self.disposeBag)
        
        switchButton.rx.controlEvent(.valueChanged)
            .withLatestFrom(switchButton.rx.value)
            .bind{(isOn) in
            print("isOn \(isOn)")
        }.disposed(by: self.disposeBag)

    }
    var isValid: Observable<Bool>{
        Observable.combineLatest(self.emailRelay.asObservable(), self.phoneRelay.asObservable())
          { (username, password) in
              return username.count > 5
                  && password.count > 3
          }
    }
    func loginTapped(){
        print("enabled")
        viewModel.authenicateUser.accept(())
//      viewModel.isLoadingBehaviourRelay.accept(true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//           self.viewModel.isLoadingBehaviourRelay.accept(false)
//        }
    }

    @IBAction func loginTapped(_ sender: Any) {
    
    }
    
}
