//
//  ViewController.swift
//  StarShareCorePodSpec
//
//  Created by BUBUKO on 2018/3/20.
//  Copyright © 2018年 bugu. All rights reserved.
//

import UIKit
import RxSwift

final class StarShareCore: Core {
  static let shared = StarShareCore()
}

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    _ = StarShareCore.shared.request(V2EX(), to: Node.self).subscribe { e in
      print(e.element ?? "request error")
    }
    
    _ = StarShareCore.shared.loadCacheIfNeed(V2EX(), to: Node.self).subscribe { e in
      print(e.element ?? "load cache error")
    }
  }
}

