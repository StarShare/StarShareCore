//
//  V2EXCache.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/20.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation

struct V2EXCache: CacheBean {
  var enable: Bool {
    return true
  }
  
  var key: String {
    return "V2EX-Nodes"
  }
}
