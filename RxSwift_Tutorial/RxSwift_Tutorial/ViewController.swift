//
//  ViewController.swift
//  RxSwift_Tutorial
//
//  Created by 윤병일 on 2021/08/18.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  //MARK: - Properties
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .blue
  }
}

