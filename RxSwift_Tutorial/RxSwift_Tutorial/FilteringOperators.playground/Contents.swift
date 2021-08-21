import UIKit
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

// 1. ignoreElement filter

//let strikes = PublishSubject<String>()

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

//let strikes = PublishSubject<String>()

//strikes.element(at: 2).subscribe(onNext : { _ in
//  print("You are out!")
//}).disposed(by: disposeBag) // 인덱스가 2번째 이후에 프린트가 된다.
//
//strikes.onNext("X")
//strikes.onNext("X")
//strikes.onNext("X") // 이때 You are out! 이 프린트 됨

// 3. filter

//Observable.of(1,2,3,4,5,6,7)
//  .filter {
//    $0 % 2 == 0
//  }.subscribe(onNext : {
//    print($0) // 2, 4, 6 가 프린트된다.
//  }).disposed(by: disposeBag)

// 4. skip operator

Observable.of("a", "b", "c", "d", "e", "f")
  .skip(3)
  .subscribe(onNext: {
    print($0) // 3개를 띄어넘고 d, e, f 가 프린트 된다.
  }).disposed(by: disposeBag)

