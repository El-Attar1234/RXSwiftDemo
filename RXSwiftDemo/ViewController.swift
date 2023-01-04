//
//  ViewController.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 24/12/2022.
//

import UIKit
import RxSwift



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SubjectTypes.behaviourSubject()
        // Do any additional setup after loading the view.
     
    }

    

}

class SubjectTypes {
// https://ali-akhtar.medium.com/rxswift-part-1-2e8e2b9586db
    
    static func behaviourSubject(){
        let subject = BehaviorSubject(value: "Mah")
        subject.onNext("ali")
        subject.subscribe { print("onNext \($0)")} onError: { print("erroe \($0.localizedDescription)")} onCompleted: {print("onCompleted")} onDisposed: {print("onDisposed")}
        subject.onCompleted()
    }
}
