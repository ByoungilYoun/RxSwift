//
//  FirstViewController.swift
//  RxSwift_CameraFilter
//
//  Created by 윤병일 on 2021/08/19.
//

import UIKit
import SnapKit
import RxSwift

class FirstViewController: UIViewController {

  //MARK: - Properties
  let myImageView : UIImageView = {
    let v = UIImageView()
    v.contentMode = .scaleAspectFill
    v.backgroundColor = .white
    return v
  }()
  
  let myButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("Apply Filter", for: .normal)
    bt.setTitleColor(.white, for: .normal)
    bt.backgroundColor = .systemBlue
    bt.isHidden = true 
    bt.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    return bt
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkIfMyButtonShouldBeHidden()
  }

  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(clickPlus))
    navigationItem.title = "Camera Filter"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    [myImageView, myButton].forEach {
      view.addSubview($0)
    }
  
    myImageView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.70)
    }
    
    myButton.snp.makeConstraints {
      $0.top.equalTo(myImageView.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(100)
      $0.height.equalTo(50)
    }
  }
  
  private func checkIfMyButtonShouldBeHidden() {
    if myImageView.image == nil {
      myButton.isHidden = true
    } else {
      myButton.isHidden = false
    }
  }
  
  //MARK: - objc func
  @objc private func clickPlus() {
    let nav = PhotoSelectionViewController()
    navigationController?.pushViewController(nav, animated: true)
  }
  
  @objc private func buttonTap() {
    
  }
}

