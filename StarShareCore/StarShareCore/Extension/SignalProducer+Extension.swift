//
//  SignalProducer+Extension.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import ReactiveSwift
import Alamofire
import Moya
import SwiftyJSON
import HandyJSON

extension SignalProducerProtocol where Value == JSON, Error == CoreError {
  
  public func map<T>(to type: T.Type, forKeyPath: String?) -> SignalProducer<T, Error> where T: HandyJSON {
    return producer.flatMap(.latest) { response -> SignalProducer<T, Error> in
      
      var validData = response
      if let key = forKeyPath,key.count > 0 {
        validData = response[key]
      }
      guard validData.type != .null && validData.type != .unknown else {
        return SignalProducer(error: .validDataNil("Response data not found valid data."))
      }
      let model = type.deserialize(from: validData.rawString())
      guard model != nil else {
        return SignalProducer(error: .jsonModel("json data transform to \(type) model failed."))
      }
      
      return SignalProducer(value: model!)
    }
  }
  
  public func verification(_ check: Check) -> SignalProducer<Value, Error> {
    return producer.flatMap(.latest) { response -> SignalProducer<Value, Error> in
      let status = response["status"].numberValue.intValue
      let data   = response["data"]
      switch check {
      case let .successStatus(code):
        guard status == code else {
          return SignalProducer.init(error: .validStatus)
        }
      case .validData:
        guard data.type != .null && data.type != .unknown else {
          return SignalProducer.init(error: .validDataNil("Check validData failed!"))
        }
      case let .successStatusAndValidData(code):
        guard status == code else {
          return SignalProducer.init(error: .validStatus)
        }
        guard data.type != .null && data.type != .unknown else {
          return SignalProducer.init(error: .validDataNil("Check successStatusAndValidData failed!"))
        }
      default:
        return SignalProducer(value: response)
      }
      return SignalProducer(value: response)
    }
  }
}

