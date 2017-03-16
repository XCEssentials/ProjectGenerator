//
//  ViewController.swift
//  TestApp
//
//  Created by Alexander Skvortsov on 14/11/2016.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit
import TestFramework

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    self.view.viewWithTag(123)?.backgroundColor = TestStruct() is TestProtocol ? .green : .red
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

