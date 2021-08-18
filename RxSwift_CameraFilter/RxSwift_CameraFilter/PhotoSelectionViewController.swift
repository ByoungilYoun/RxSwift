//
//  PhotoSelectionViewController.swift
//  RxSwift_CameraFilter
//
//  Created by 윤병일 on 2021/08/19.
//

import UIKit
import Photos

class PhotoSelectionViewController  : UIViewController {
  
  //MARK: - Properties
  
  private var images = [PHAsset]() {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    populatePhotos()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = .white
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func configureUI() {
    view.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //MARK: - Functions
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { [weak self] status in
      guard let self = self else {return}
      
      if status == .authorized {
        // access the photos from photo library
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects { (object, count, stop) in
          self.images.append(object)
        }
        
        self.images.reverse()
        print("하하", self.images)
//        self.collectionView.reloadData()
      } 
    }
  }
}

  //MARK: - extension UICollectionViewDataSource
extension PhotoSelectionViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }
}
  //MARK: - extension UICollectionViewDelegate
extension PhotoSelectionViewController : UICollectionViewDelegate {
  
}
