//
//  DictionaryExtension.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/20.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation

public extension Dictionary {
  
  public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach { result[$0] = $1 }
    return result
  }
}
