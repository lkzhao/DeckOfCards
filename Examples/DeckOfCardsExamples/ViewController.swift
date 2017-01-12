//
//  ViewController.swift
//  DeckOfCardsExamples
//
//  Created by YiLun Zhao on 2017-01-11.
//  Copyright © 2017 Luke Zhao. All rights reserved.
//

import UIKit
import DeckOfCards

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  @IBAction func deck(_ sender: Any) {
    present(DeckViewController(), animated: true, completion: nil)
  }
}

