//
//  CacheCore.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/19.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Cache
import HandyJSON

public protocol CacheAware {
  
  func save<T: Codable>(_ object: T,forKey key: String) throws
  func save<T: HandyJSON>(_ object: T,forKey key: String) throws
  func save<T: Codable>(_ object: T,forDomainBean bean: DomainBean) throws
  func save<T: HandyJSON>(_ object: T,forDomainBean bean: DomainBean) throws
  
  func fetch<T: Codable>(ofType type: T.Type, forKey key: String) throws -> T?
  func fetch<T: HandyJSON>(ofType type: T.Type, forKey key: String) throws -> T?
  func fetch<T: Codable>(ofType type: T.Type, forDomainBean bean: DomainBean) throws -> T?
  func fetch<T: HandyJSON>(ofType type: T.Type, forDomainBean bean: DomainBean) throws -> T?
}

public class CacheCore: CacheAware {
  
  static let responseCache = CacheCore(responseCacheCore)
  fileprivate static let responseCacheCore = try! Storage(
    diskConfig: DiskConfig(
    name: "share-response-cache",
    expiry: .never,
    maxSize: 10000,
    directory: try! FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: true).appendingPathComponent("StarShareCoreCache"),
    protectionType: .complete
    ), memoryConfig: MemoryConfig(
      expiry: .never,
      countLimit: 50,
      totalCostLimit: 0
  ))
  
  fileprivate var currentStorage: Storage
  init(_ storage: Storage) {
    currentStorage = storage
  }
  
  public func save<T: Codable>(_ object: T,forKey key: String) throws {
    try self.currentStorage.setObject(object, forKey: key)
  }
  
  public func save<T: HandyJSON>(_ object: T,forKey key: String) throws {
    let object = object.toJSONString()
    try self.save(object, forKey: key)
  }
  
  public func save<T: Codable>(_ object: T,forDomainBean bean: DomainBean) throws {
    if let cacheBean = bean.cacheBean {
      if cacheBean.enable == true {
        let key = cacheBean.key
        guard key.count > 0 else {
          return
        }
        try self.save(object, forKey: key)
      }
    }
  }
  
  public func save<T: HandyJSON>(_ object: T,forDomainBean bean: DomainBean) throws {
    if let cacheBean = bean.cacheBean {
      if cacheBean.enable == true {
        let key = cacheBean.key
        guard key.count > 0 else {
          return
        }
        try self.save(object, forKey: key)
      }
    }
  }
  
  public func fetch<T: Codable>(ofType type: T.Type, forKey key: String) throws -> T? {
    return try self.currentStorage.entry(ofType: type, forKey: key).object
  }
  
  public func fetch<T: HandyJSON>(ofType type: T.Type, forKey key: String) throws -> T? {
    let object = try self.fetch(ofType: String.self, forKey: key)
    return type.deserialize(from: object)
  }
  
  public func fetch<T: Codable>(ofType type: T.Type, forDomainBean bean: DomainBean) throws -> T? {
    if let cacheBean = bean.cacheBean {
      if cacheBean.enable == true {
        let key = cacheBean.key
        guard key.count > 0 else {
          return nil
        }
        return try self.fetch(ofType: type, forKey: key)
      }
    }
    
    return nil
  }
  
  public func fetch<T: HandyJSON>(ofType type: T.Type, forDomainBean bean: DomainBean) throws -> T? {
    let object = try self.fetch(ofType: String.self, forDomainBean: bean)
    return type.deserialize(from: object)
  }
}
