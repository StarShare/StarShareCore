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
import SwiftyJSON

public typealias HTTPMethod  = Moya.Method
public typealias HTTPTask    = Moya.Task

public protocol Core {
  
  associatedtype Error: Swift.Error
  
  /// 网络引擎的一些简单的配置，包含根域名，公共参数等
  ///
  /// - Returns: 配置(Config).
  func configuration() -> Config
  
  /// 通过 ‘DomainBean’ 从本地读取缓存数据
  ///
  /// - Parameters:
  ///   - domainBean: 网络请求的一些参数封装
  ///   - type: 数据模型类型
  /// - Returns: Observable with RxSwift
  @discardableResult
  func loadCacheIfNeed<T>(_ domainBean: DomainBean,
                          to type: T.Type) -> Observable<T> where T: HandyJSON
  
  /// 创建一个普通的网络请求，底层使用 ‘Alamofire’ 、‘RxSwift’
  ///
  /// - Parameters:
  ///   - domainBean: 网络请求的一些参数封装
  ///   - type: 数据模型类型
  /// - Returns: Observable with RxSwift
  @discardableResult
  func request<T>(_ domainBean: DomainBean,
                  to type: T.Type) -> Observable<T> where T: HandyJSON
  
  /// 创建一个上传文件的网络请求，底层使用 ‘Alamofire’ 、‘RxSwift’
  ///
  /// - Parameter domainBean: 网络请求的一些参数封装
  /// - Returns: Observable with RxSwift
  @discardableResult
  func upload(_ domainBean: DomainBean) -> Observable<ProgressResponse>
  
  /// 创建一个下载文件的网络请求，底层使用 ‘Alamofire’ 、‘RxSwift’
  ///
  /// - Parameter domainBean: 网络请求的一些参数封装
  /// - Returns: Observable with RxSwift
  @discardableResult
  func download(_ domainBean: DomainBean) -> Observable<ProgressResponse>
}

extension Core {
  
  typealias Error = CoreError
  
  public func configuration() -> Config {
    return Config.default
  }
  
  @discardableResult
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
  
  @discardableResult
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
  
  @discardableResult
  func upload(_ domainBean: DomainBean) -> Observable<ProgressResponse> {
    
    return MoyaProvider<MoyaTarget>(plugins: [PreludePlugin(),
                                              PreparePlugin(),
                                              LogPlugin(),
                                              ProcessPlugin()])
      .rx
      .progressRequest(domainBean.asMoyaTarget())
  }
  
  @discardableResult
  func download(_ domainBean: DomainBean) -> Observable<ProgressResponse> {
    
    return MoyaProvider<MoyaTarget>(plugins: [PreludePlugin(),
                                              PreparePlugin(),
                                              LogPlugin(),
                                              ProcessPlugin()])
      .rx
      .progressRequest(domainBean.asMoyaTarget())
  }
}
