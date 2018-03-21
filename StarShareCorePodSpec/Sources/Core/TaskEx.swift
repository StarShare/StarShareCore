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
  
  public func mapping(with domainBean: DomainBean) -> Task {
    
    let publicParameters = domainBean.publicParameters ?? [:]
    var task: Task
    switch self {
    case .requestPlain:
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case let .requestData(data):
      task = .requestCompositeData(bodyData: data, urlParameters: publicParameters)
    case .requestJSONEncodable(_):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case .requestCustomJSONEncodable(_, _):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case .requestParameters(let parameters, let encoding):
      task = .requestParameters(parameters: parameters + publicParameters, encoding: encoding)
    case .requestCompositeData(let bodyData, let urlParameters):
      task = .requestCompositeData(bodyData: bodyData, urlParameters: urlParameters + publicParameters)
    case .requestCompositeParameters(let bodyParameters, let bodyEncoding, let urlParameters):
      task = .requestCompositeParameters(bodyParameters: bodyParameters,
                                         bodyEncoding: bodyEncoding,
                                         urlParameters: urlParameters + publicParameters)
    case .uploadFile(_):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case .uploadMultipart(_):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case .uploadCompositeMultipart(_, _):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case .downloadDestination(_):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    case .downloadParameters(_, _, _):
      task = .requestParameters(parameters: publicParameters, encoding: URLEncoding.default)
    }
    
    return task
  }
}
