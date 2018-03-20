//
//  ProcessPlugin.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/20.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation
import Moya
import Result
import SwiftyJSON
import HandyJSON

final class ProcessPlugin: PluginType {
  
  func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
    return result
  }
}
