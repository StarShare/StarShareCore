//
//  MoyaProviderExtension.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON
import HandyJSON

extension MoyaProvider: ReactiveCompatible {}

public extension Reactive where Base: MoyaProviderType {
  
  public func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<JSON> {
    return Observable.create({ observer -> Disposable in
      let cancellableToken = self.base.request(token, callbackQueue: callbackQueue, progress: nil) { result in
        switch result {
        case let .success(response):
          let json = JSON(response.data)
          guard json.type != .null && json.type != .unknown else {
            observer.onError(CoreError.responseSerializer(response))
            return
          }
          observer.onNext(json)
          observer.onCompleted()
        case let .failure(error):
          observer.onError(CoreError.moyaError(error))
        }
      }
      
      return Disposables.create {
        cancellableToken.cancel()
      }
    })
  }
}

