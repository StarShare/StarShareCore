//
//  CachePlugin.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya
import Result
import SwiftyJSON
import HandyJSON

final class CachePlugin: PluginType {
  
  var domainBean: DomainBean
  init(_ bean: DomainBean) {
    domainBean = bean
  }
  
  func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    if case let .success(response) = result {
      if let cacheBean = domainBean.cacheBean {
        if cacheBean.enable == true {
          let key = cacheBean.key
          guard key.count > 0 else {
            return
          }
          let json   = JSON(response.data)
          let status = json["status"].numberValue.intValue
          let data   = json["data"]
          switch domainBean.check {
          case let .successStatus(code):
            guard status == code else {
              return
            }
          case .validData:
            guard data.type != .null && data.type != .unknown else {
              return
            }
          case let .successStatusAndValidData(code):
            guard status == code else {
              return
            }
            guard data.type != .null && data.type != .unknown else {
              return
            }
          default:
            break
          }
          
          try! CacheCore.responseCache.save(json.rawString(),
                                            forKey: key)
        }
      }
    }
  }
}
