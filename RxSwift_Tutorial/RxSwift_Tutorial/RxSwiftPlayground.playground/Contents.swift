import UIKit
import RxSwift


//let observable = Observable.just(1)
//
//let observable2 = Observable.of(1,2,3) // 배열이 아니라 Int 여러개
//
//let observable3 = Observable.of([1,2,3,])
//
//let observable4 = Observable.from([1,2,3,4,5]) // from 각각 개인

//observable4.subscribe { event in
//  if let element = event.element {
//    print(element) //1
//                   //2
//                   //3
//                   //4
//                   //5
//  }
//}

//observable2.subscribe(onNext : { element in
//  print(element) //1
//                 //2
//                 //3
//})

//observable3.subscribe { event in
//  if let element = event.element {
//    print(element) // [1,2,3]
//  }
//}

//observable4.subscribe(onNext : { element in // 이 방법을 쓰면 옵셔널 바인딩을 처리 안해줘도 된다.
//  print(element)  //1
//                  //2
//                  //3
//                  //4
//                  //5
//})

// -------------------------------------------------------------------------------------------------------
// dispose

//let subscription4 = observable4.subscribe { element in
//  print(element)
//}
//
//subscription4.dispose() // 메모리 릭이 발생하지 않도록 dispose(처분) 을 해줘야한다.

// dispose 를 좋게 쓰는 방법 1 - disposeBag 프로퍼티를 생성해서 사용
//let disposeBag = DisposeBag()
//
//Observable.of("A","B","C")
//  .subscribe {
//    print($0)
//  }.disposed(by: disposeBag)

// dispose 를 좋게 쓰는 방법 2 - create function 사용
//Observable<String>.create { observer in
//  observer.onNext("A")
//  observer.onCompleted()
//  observer.onNext("?") // 위에 onCompleted 뒤에 "?" 는 프린트가 되지 않는다.
//  return Disposables.create()
//}.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("Completed")}, onDisposed: {print("Disposed")})
//.disposed(by: disposeBag)

//-----------------------------------------------------------------------------------------------------------
// Subjects - 옵저버블이자 옵저버 역할을 한다.

let disposeBag = DisposeBag()

// 1. Publish Subjects

//let subject = PublishSubject<String>()
//
//subject.onNext("Issue 1")
//
//subject.subscribe { event in
//  print(event)
//}
//
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
////subject.dispose()
////subject.onCompleted()
//subject.onNext("Issue 4")

// 2. Behavior Subjects - initial value 가 있어야한다. , 하나의 초기값을 가지고 있어야 하고 초기값을 가지고 있는 상태이기 때문에 초기 값으로 next이벤트로 값이 전달되면서 시작. 구독을 시작했을때 직전의 값을 전달 받고 시작한다. 

let subject = BehaviorSubject(value: "Initial Value")

subject.onNext("Last Issue")

subject.subscribe { event in
  print(event)
}

subject.onNext("Issue 1")