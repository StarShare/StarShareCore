//
//  LogPlugin.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya
import Result
import SwiftyJSON

final class LogPlugin: PluginType {
  
  public func willSend(_ request: RequestType, target: TargetType) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    print("*--------------------------Request--------------------------*")
    print(target.baseURL.absoluteString + target.path)
    print("*Method:")
    print(target.method)
    print("*Parameters:")
    print(target.task)
    print("*Header:")
    print(target.headers ?? "")
    print("*--------------------------------------------------------------*")
  }
  
  public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    print("*---------------------------Response---------------------------*")
    
    switch result {
    case .success(let response):
      do {
        let json = JSON(response.data)
        print(json)
      }
    case .failure(let error):
      print(error)
    }
    print("*-------------------------------------------------------------*")
  }
}

