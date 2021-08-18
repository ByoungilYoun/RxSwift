import UIKit
import RxSwift


let observable = Observable.just(1)

let observable2 = Observable.of(1,2,3) // 배열이 아니라 Int 여러개

let observable3 = Observable.of([1,2,3,])

let observable4 = Observable.from([1,2,3,4,5]) // from 각각 개인

observable4.subscribe { event in
  if let element = event.element {
    print(element) //1
                   //2
                   //3
                   //4
                   //5
  }
}

observable2.subscribe(onNext : { element in
  print(element) //1
                 //2
                 //3
})

observable3.subscribe { event in
  if let element = event.element {
    print(element) // [1,2,3]
  }
}

observable4.subscribe(onNext : { element in // 이 방법을 쓰면 옵셔널 바인딩을 처리 안해줘도 된다.
  print(element)  //1
                  //2
                  //3
                  //4
                  //5
})
