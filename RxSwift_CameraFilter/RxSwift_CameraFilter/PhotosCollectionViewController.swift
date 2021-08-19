//
//  PhotosCollectionViewController.swift
//  RxSwift_CameraFilter
//
//  Created by 윤병일 on 2021/08/19.
//

import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController  : UIViewController {
  
  //MARK: - Properties

  private let selectedPhotoSubject = PublishSubject<UIImage>()
  
  var selectedPhoto : Observable<UIImage> {
    return selectedPhotoSubject.asObservable()
  }
  
  private var images = [PHAsset]()
  
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
    collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
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
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      } 
    }
  }
}

  //MARK: - extension UICollectionViewDataSource
extension PhotosCollectionViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
      fatalError("PhotoCollectionViewCell is not found")
    }
    let asset = self.images[indexPath.row]
    let manager = PHImageManager.default()
    manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { image, _ in
      DispatchQueue.main.async {
        cell.imageView.image = image
      }
    }

    return cell
  }
}
  //MARK: - extension UICollectionViewDelegate
extension PhotosCollectionViewController : UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedAsset = self.images[indexPath.row]

    PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil) { [weak self] image, info in
      
      guard let info = info else {return}
      
      let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
      
      if !isDegradedImage {
        if let image = image {
          self?.selectedPhotoSubject.onNext(image)
          self?.navigationController?.popViewController(animated: true)
        }
      }
    }
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension PhotosCollectionViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
}
