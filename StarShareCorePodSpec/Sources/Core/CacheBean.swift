//
//  CacheBean.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/19.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation

public protocol CacheBean {
  
  var enable: Bool { get }
  var key: String { get }
}

public extension CacheBean {
  
  var enable: Bool {
    return false
  }
  
  var key: String {
    return ""
  }
}
