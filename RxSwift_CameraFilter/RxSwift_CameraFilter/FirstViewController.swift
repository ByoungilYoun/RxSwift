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
    v.clipsToBounds = true
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
  
  let disposeBag = DisposeBag()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(clickPlus))
    navigationItem.title = "Camera Filter"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
    
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
  
  private func updateUI(with image : UIImage) {
      self.myImageView.image = image
      self.myButton.isHidden = false
  }
  
  //MARK: - objc func
  @objc private func clickPlus() {
    let nav = PhotosCollectionViewController()
    
    nav.selectedPhoto.subscribe { [weak self] photo in
      DispatchQueue.main.async {
        self?.updateUI(with: photo)
      }
    }.disposed(by: disposeBag)
    
    navigationController?.pushViewController(nav, animated: true)
  }
  
  @objc private func buttonTap() {
    guard let sourceImage = self.myImageView.image else {
      return
    }
    
    FilterService().applyFilter(to: sourceImage).subscribe(onNext : { filteredImage in
      DispatchQueue.main.async {
        self.myImageView.image = filteredImage
      }
    }).disposed(by: disposeBag)
  }
}

