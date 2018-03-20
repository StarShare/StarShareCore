//
//  DomainBean.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import HandyJSON

public protocol DomainBean {
  
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var task: HTTPTask { get }
  var headers: [String: String]? { get }
  var check: Check { get }
  var cacheBean: CacheBean? { get }
}

extension DomainBean {
  var baseURL: URL {
    return Config.default.baseURL!
  }
  
  var check: Check {
    return .successStatusAndValidData(1)
  }
  
  var cacheBean: CacheBean? {
    return nil
  }
}

extension DomainBean {
  func asMoyaTarget() -> MoyaTarget {
    return MoyaTarget(self)
  }
}

public struct MoyaTarget: TargetType {
  
  private var domainBean: DomainBean
  
  public var baseURL: URL {
    return domainBean.baseURL
  }
  
  public var path: String {
    return domainBean.path
  }
  
  public var method: Moya.Method {
    return domainBean.method
  }
  
  public var sampleData: Data {
    return "StarShareCore".data(using: String.Encoding.utf8)!
  }
  
  public var task: Task {
    return domainBean.task
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
  
  public var headers: [String: String]? {
    return domainBean.headers
  }
  
  init(_ domainBean: DomainBean) {
    self.domainBean = domainBean
  }
}
