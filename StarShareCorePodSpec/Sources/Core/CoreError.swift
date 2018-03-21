//
//  CoreError.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya

// MARK: - CoreError

public enum CoreError: Swift.Error {
  
  /// request Error.
  case moyaError(MoyaError)
  
  /// json data transform to Object Model
  case responseSerializer(Response)
  
  /// json data status not right
  case validStatus
  
  /// json data business error
  case businessError(String?)
  
  /// json data not a valid data
  case validDataNil(String)
  
  /// json data transform to Object Model
  case jsonModel(String)
  
  /// cache data is null
  case noneCache
}

public extension CoreError {
  
  /// Depending on error type, returns a `Response` object.
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
  
  /// RequestCommonError Error Descriptions
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
