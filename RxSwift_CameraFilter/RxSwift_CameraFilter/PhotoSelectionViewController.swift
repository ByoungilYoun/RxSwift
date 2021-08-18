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
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    populatePhotos()
  }
  
  //MARK: - Functions
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { status in
      if status == .authorized {
        // access the photos from photo library
      } 
    }
  }
}
