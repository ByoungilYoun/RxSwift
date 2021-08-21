import UIKit
import RxSwift
import PlaygroundSupport


// 1. ignoreElement filter

//let strikes = PublishSubject<String>()
//let disposeBag = DisposeBag()
//
//strikes
//  .ignoreElements()
//    .subscribe { _ in
//      print("[Subscription is called]")
//  }.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C") // 여기까지 안불림
//
//strikes.onCompleted() // 이걸 하면 [Subscription is called] 여기가 프린트됨


// 2. elementAt filter

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

strikes.element(at: 2).subscribe(onNext : { _ in
  print("You are out!")
}).disposed(by: disposeBag) // 인덱스가 2번째 이후에 프린트가 된다.

strikes.onNext("X")
strikes.onNext("X")
strikes.onNext("X") // 이때 You are out! 이 프린트 됨 
