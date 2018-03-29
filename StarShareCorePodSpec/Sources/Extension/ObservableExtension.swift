//
//  ObservableExtension.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Moya
import SwiftyJSON
import HandyJSON

public extension ObservableType where E == JSON {
  
  public func map<T>(to type: T.Type, forKeyPath: String?) -> Observable<T> where T: HandyJSON {

    return flatMap({ json -> Observable<T> in
      var validData = json
      if let key = forKeyPath,key.count > 0 {
        validData = json[key]
      }
      guard validData.type != .null && validData.type != .unknown else {
        return Observable.error(CoreError.validDataNil("Response data not found valid data."))
      }
      let model = type.deserialize(from: validData.rawString())
      guard model != nil else {
        return Observable.error(CoreError.jsonModel("json data transform to \(type) model failed."))
      }
      
      return Observable.just(model!)
    })
  }
  
  public func verification(_ check: Check) -> Observable<E> {
    
    return flatMap({ json -> Observable<E> in
      let status = json["status"].numberValue.intValue
      let data   = json["data"]
      switch check {
      case let .successStatus(code):
        guard status == code else {
          return Observable.error(CoreError.validStatus)
        }
      case .validData:
        guard data.type != .null && data.type != .unknown else {
          return Observable.error(CoreError.validDataNil("Check validData failed!"))
        }
      case let .successStatusAndValidData(code):
        guard status == code else {
          return Observable.error(CoreError.validStatus)
        }
        guard data.type != .null && data.type != .unknown else {
          return Observable.error(CoreError.validDataNil("Check successStatusAndValidData failed!"))
        }
      default:
        return Observable.just(json)
      }
      return Observable.just(json)
    })
  }
}

