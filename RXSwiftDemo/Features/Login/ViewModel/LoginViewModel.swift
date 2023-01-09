//
//  LoginViewModel.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 08/01/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
}
protocol LoginViewModelInput {
    var emailBehaviourRelay: BehaviorRelay<Bool> { get set }
    var phoneBehaviourRelay: BehaviorRelay<Bool> { get set }
    var authenicateUser: PublishRelay<Void> { get set }
}

protocol LoginViewModelOutput{
    var isLoadingBehaviourRelay: BehaviorRelay<Bool> { get set }
}
extension LoginViewModelOutput {
    var isValidForm: Driver<Bool> {
        Observable.of(false).asDriver(onErrorJustReturn: false)
    }
    
}

 typealias LoginViewModelProtocol = LoginViewModelInput & LoginViewModelOutput


class LoginViewModel: LoginViewModelProtocol{
    
     let disposeBag = DisposeBag()
   // struct Input {
        var emailBehaviourRelay = BehaviorRelay<Bool>(value: false)
        var phoneBehaviourRelay = BehaviorRelay<Bool>(value: false)
        var authenicateUser = PublishRelay<Void>()
    
    init() {
        setupBindings()
    }
    
    func setupBindings(){
        authenicateUser.subscribe { _ in
            self.isLoadingBehaviourRelay.accept(true)
              DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                 self.isLoadingBehaviourRelay.accept(false)
              }
        }.disposed(by: disposeBag)
    }
        
    //}
    
  //  struct Output {
    var isLoadingBehaviourRelay = BehaviorRelay<Bool>(value: false)
    var isValidForm: Driver<Bool> {
        Observable.combineLatest(emailBehaviourRelay, phoneBehaviourRelay)
        { (username, password) in
            return username && password
        }.asDriver(onErrorJustReturn: false)}
    
   

//
//    func transForm(input: Input) -> Output{
//        let isValid  =  Observable.combineLatest(input.emailBehaviourRelay, input.emailBehaviourRelay)
//          { (username, password) in
//              return username && password
//          }
//        let output = Output(isValidForm: isValid.asDriver(onErrorJustReturn: false))
//        return output
//    }
//

    
}
