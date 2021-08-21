import UIKit
import RxSwift
import PlaygroundSupport


// 1. ignoreElement filter

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

strikes
  .ignoreElements()
    .subscribe { _ in
      print("[Subscription is called]")
  }.disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onNext("C") // 여기까지 안불림

strikes.onCompleted() // 이걸 하면 [Subscription is called] 여기가 프린트됨
