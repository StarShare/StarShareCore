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
import RxSwift
import HandyJSON

public typealias HTTPMethod  = Moya.Method
public typealias HTTPTask    = Moya.Task

public protocol Core {
  
  associatedtype Error: Swift.Error
  
  func configuration() -> Config
  
  func request<T>(_ domainBean: DomainBean,
                  to type: T.Type) -> Observable<T> where T: HandyJSON
  
  func loadCacheIfNeed<T>(_ domainBean: DomainBean,
                          to type: T.Type) -> Observable<T> where T: HandyJSON
}

extension Core {
  
  typealias Error = CoreError
  
  public func configuration() -> Config {
    return Config.default
  }
  
  public func request<T>(_ domainBean: DomainBean,
                         to type: T.Type) -> Observable<T> where T: HandyJSON {
    
    return MoyaProvider<MoyaTarget>(plugins: [PreludePlugin(),
                                              PreparePlugin(),
                                              LogPlugin(),
                                              CachePlugin(domainBean),
                                              ProcessPlugin()])
      .rx
      .request(domainBean.asMoyaTarget())
      .verification(domainBean.check)
      .map(to: type, forKeyPath: "data")
  }
  
  public func loadCacheIfNeed<T>(_ domainBean: DomainBean,
                                 to type: T.Type) -> Observable<T> where T: HandyJSON {
    
    return Observable.create({ observer -> Disposable in
      let cache = try? CacheCore.responseCache.fetch(ofType: type, forDomainBean: domainBean)
      if let cache = cache {
        observer.onNext(cache!)
        observer.onCompleted()
      } else {
        observer.onError(CoreError.noneCache)
      }
      
      return Disposables.create()
    })
  }
}
