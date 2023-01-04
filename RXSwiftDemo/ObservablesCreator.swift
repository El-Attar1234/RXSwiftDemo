//
//  ObservablesCreator.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 24/12/2022.
//

import Foundation
import RxSwift

class ObservableCreator {
    
    static func justType(){
        let observable = Observable.just(10)
        observable.subscribe { print("onNext \($0)")} onError: { print("erroe \($0.localizedDescription)")} onCompleted: {print("onCompleted")} onDisposed: {print("onDisposed")}

    }
    static func ofType(){
        let observable = Observable.of(["tt"], [10])
        observable.subscribe { print("onNext \($0)")} onError: { print("erroe \($0.localizedDescription)")} onCompleted: {print("onCompleted")} onDisposed: {print("onDisposed")}

    }
    static func fromType(){
        let observable = Observable.from([10,3])
        observable.subscribe { print("onNext \($0)")} onError: { print("erroe \($0.localizedDescription)")} onCompleted: {print("onCompleted")} onDisposed: {print("onDisposed")}

    }
    static func createType(){
        let observable = Observable.create { observer in
            observer.onNext(10)
            observer.onNext(20)
            observer.onCompleted()
            return Disposables.create()
        }
        observable.subscribe { print("onNext \($0)")} onError: { print("erroe \($0.localizedDescription)")} onCompleted: {print("onCompleted")} onDisposed: {print("onDisposed")}

    }
}
