//
//  Config.swift
//  StarShareCore
//
//  Created by BUBUKO on 2018/3/15.
//  Copyright © 2018年 bugu. All rights reserved.
//

import Foundation

final class Config {
  
  public static let shared = Config()
  
  var baseURL: URL?
  var publicParameters: [String:String]?
}
