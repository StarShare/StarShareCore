//
//  TaskEx.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya

public extension Task {
  
  public static func publicParameters() -> [String : String] {
    return Config.shared.publicParameters ?? [:]
  }
}

public extension MoyaProvider {
  public final class func oursNormallEndpointMapping(for target: Target) -> Endpoint {
    
    var task: Task
    switch target.task {
    case .requestPlain:
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case let .requestData(data):
      task = .requestCompositeData(bodyData: data, urlParameters: Task.publicParameters())
    case .requestJSONEncodable(_):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case .requestCustomJSONEncodable(_, _):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case .requestParameters(let parameters, let encoding):
      task = .requestParameters(parameters: parameters + Task.publicParameters(), encoding: encoding)
    case .requestCompositeData(let bodyData, let urlParameters):
      task = .requestCompositeData(bodyData: bodyData, urlParameters: urlParameters + Task.publicParameters())
    case .requestCompositeParameters(let bodyParameters, let bodyEncoding, let urlParameters):
      task = .requestCompositeParameters(bodyParameters: bodyParameters,
                                         bodyEncoding: bodyEncoding,
                                         urlParameters: urlParameters + Task.publicParameters())
    case .uploadFile(_):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case .uploadMultipart(_):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case .uploadCompositeMultipart(_, _):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case .downloadDestination(_):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    case .downloadParameters(_, _, _):
      task = .requestParameters(parameters: Task.publicParameters(), encoding: URLEncoding.default)
    }
    
    return Endpoint(
      url: URL(target: target).absoluteString,
      sampleResponseClosure: { .networkResponse(200, target.sampleData) },
      method: target.method,
      task: target.task,
      httpHeaderFields: target.headers
      ).replacing(task: task)
  }
}
