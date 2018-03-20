//
//  MoyaProviderExtension.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import ReactiveSwift
import Moya
import SwiftyJSON
import HandyJSON

extension MoyaProvider: ReactiveExtensionsProvider {}

public extension Reactive where Base: MoyaProviderType {
  
  public func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> SignalProducer<JSON, CoreError> {
    return base.reactiveRequest(token, callbackQueue: callbackQueue)
  }
}

internal extension MoyaProviderType {
  
  internal func reactiveRequest(_ token: Target, callbackQueue: DispatchQueue?) -> SignalProducer<JSON, CoreError> {
    return SignalProducer {  observer, lifetime in
      let cancellableToken = self.request(token, callbackQueue: callbackQueue, progress: nil) { result in
        switch result {
        case let .success(response):
          let json = JSON(response.data)
          guard json.type != .null && json.type != .unknown else {
            observer.send(error: .responseSerializer(response))
            return
          }
          observer.send(value: json)
          observer.sendCompleted()
        case let .failure(error):
          observer.send(error: .moyaError(error))
        }
      }
      
      lifetime.observeEnded {
        cancellableToken.cancel()
      }
    }
  }
}


