//
//  V2EX.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/19.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Alamofire

final class V2EX: DomainBean {
  
  var baseURL: URL {
    return URL(string: "https://www.v2ex.com/api")!
  }
  
  var path: String {
    return "/nodes/show.json"
  }
  
  var method: HTTPMethod {
    return HTTPMethod.get
  }
  
  var task: HTTPTask {
    return HTTPTask.requestParameters(parameters: ["name":"python"],
                                      encoding: URLEncoding.default)
  }
  
  var check: Check {
    return .none
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var cacheBean: CacheBean? {
    return V2EXCache()
  }
}
