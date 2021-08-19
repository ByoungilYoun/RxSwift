//
//  PhotoCollectionViewCell.swift
//  RxSwift_CameraFilter
//
//  Created by 윤병일 on 2021/08/19.
//

import UIKit

class PhotoCollectionViewCell : UICollectionViewCell {
  
  //MARK: - Properties
  static let identifier = "PhotoCollectionViewCell"
  
  let imageView : UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  //MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    contentView.addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
