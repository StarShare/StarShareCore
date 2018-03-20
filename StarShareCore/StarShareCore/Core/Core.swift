//
//  File.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import ReactiveSwift
import HandyJSON

public typealias HTTPMethod  = Moya.Method
public typealias HTTPTask    = Moya.Task

public protocol Core {
  associatedtype Error: Swift.Error
  
  func request<T>(_ domainBean: DomainBean,
                  to type: T.Type) -> SignalProducer<T, Error> where T: HandyJSON
  
  func loadCacheIfNeed<T>(_ domainBean: DomainBean,
                          to type: T.Type) -> SignalProducer<T, Error> where T: HandyJSON
}
