//
//  CoreError.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya

public enum CoreError: Swift.Error {
  
  case moyaError(MoyaError)
  case responseSerializer(Response)
  case validStatus
  case businessError(String?)
  case validDataNil(String)
  case jsonModel(String)
  case noneCache
}

public extension CoreError {
  
  var response: Moya.Response? {
    switch self {
    case .moyaError(let error): return error.response
    case .validStatus: return nil
    case .businessError: return nil
    case .validDataNil: return nil
    case .jsonModel: return nil
    case .responseSerializer(let response): return response
    case .noneCache: return nil
    }
  }
}

extension CoreError: LocalizedError {
  
  public var errorDescription: String? {
    switch self {
    case .moyaError(let error):
      return error.localizedDescription
    case .validStatus:
      return "json data status not right."
    case .businessError(let description):
      return description
    case .validDataNil(let description):
      return description
    case .jsonModel(let description):
      return description
    case .responseSerializer:
      return "response serializer failed."
    case .noneCache:
      return "not load cache."
    }
  }
}
