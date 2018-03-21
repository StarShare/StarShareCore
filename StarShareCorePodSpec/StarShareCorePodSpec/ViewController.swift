//
//  ViewController.swift
//  StarShareCorePodSpec
//
//  Created by BUBUKO on 2018/3/20.
//  Copyright © 2018年 bugu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    StarShareCore.shared.request(V2EX(), to: Node.self).startWithResult { r in
      print(r.value ?? "null")
      
      let cacheValue = try! CacheCore.responseCache.fetch(ofType: Node.self, forDomainBean: V2EX())
      print(cacheValue ?? "null")
    }
 
    StarShareCore.shared.loadCacheIfNeed(V2EX(), to: Node.self).startWithResult { r in
      print(r.value ?? "null")
    }
  }
}

