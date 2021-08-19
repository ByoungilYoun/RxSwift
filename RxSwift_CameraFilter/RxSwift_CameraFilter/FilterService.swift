//
//  FilterService.swift
//  RxSwift_CameraFilter
//
//  Created by 윤병일 on 2021/08/20.
//

import UIKit
import CoreImage // 필터 입히기 위해
import RxSwift

class FilterService {
  
  //MARK: - Properties
  private var context : CIContext
  
  //MARK: - Init
  init() {
    self.context = CIContext()
  }
  
  //MARK: - Functions
  
  func applyFilter(to inputImage : UIImage) -> Observable<UIImage> {
    return Observable<UIImage>.create { observer in
      self.applyFilter(to: inputImage) { filteredImage in
        observer.onNext(filteredImage)
      }
      return Disposables.create()
    }
  }
  
  private func applyFilter(to inputImage : UIImage, completion : @escaping ((UIImage) -> Void)) {
    let filter = CIFilter(name: "CICMYKHalftone")
    filter?.setValue(5.0, forKey: kCIInputWidthKey)
    
    if let sourceImage = CIImage(image: inputImage) {
      filter?.setValue(sourceImage, forKey: kCIInputImageKey)
      
      guard let outputImage = filter?.outputImage else {return}
      
      if let cgimg = self.context.createCGImage(outputImage, from: outputImage.extent) {
        let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        completion(processedImage)
      }
    }
  }
}

