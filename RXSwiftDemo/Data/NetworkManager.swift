//
//  NetworkManager.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 26/12/2022.
//

import Foundation
import Moya
import RxSwift

protocol NetworkService {
    func request<E, T>(targetApi: E, responseModel: T.Type) -> Single<T?> where E: TargetType, T: Codable
}

final class DefaultNetworkService : NetworkService {
    
    private let disposeBag = DisposeBag()
    
    public init() {
    }
}

extension DefaultNetworkService {
    
    func request<E, T>(targetApi: E, responseModel: T.Type) -> Single<T?> where E : TargetType, T: Codable{
        return Single<T?>.create { [unowned self] single in
            let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            let provider = MoyaProvider<E>(plugins: [NetworkLoggerPlugin(configuration: loggerConfig)])
            
            provider.rx.requestWithProgress(targetApi).subscribe(onNext: {[unowned self] response in

                
                
                
                if let apiResponse = response.response {
                    
                    //
                    //      print(try? JSONSerialization.jsonObject(with: apiResponse.data, options: .allowFragments))
                    //if api accidentally return erro in response body
                    if (200...299).contains(apiResponse.statusCode) {
                        let result : Result<T?, NetworkError> = self.responseDecoder(response: apiResponse)
                        switch result {
                        case .success(let data):
                            single(.success(data))
                        case .failure(let error):
                            single(.failure(error))
                        }
                    }else{
                        single(.failure(NetworkError.error(statusCode: response.response?.statusCode ?? 0, data: response.response?.data)))
                    }
                }
            }, onError: {[unowned self] error in
              //  let error: NetworkError = self.resolve(error: error)
                single(.failure(error))
            }).disposed(by: disposeBag)
            return Disposables.create {}
        }
    }
    
    private func responseDecoder<T: Codable>(response: Response) -> Result<T?, NetworkError> {
           var isJson = true
           do {
               do {
                   _ = try response.mapJSON()
               }catch {
                   isJson = false
               }
               
               var body : T?
               if T.self != Nil.self {
                   if isJson {
                       body = try response.map(T.self)
                   } else {
                       body = nil
                   }
               } else {
                   body = nil
               }
               return .success(body)
           }catch let error {
               let error = ErrorHandling .resolve(error: error)
               return .failure(error)
           }
       }

}


   


struct Nil : Codable {
   
}
