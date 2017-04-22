import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let myFirstObservable = Observable<Int>.create { observer in
    observer.on(.next(1))
    observer.on(.next(2))
    observer.on(.next(3))
    observer.on(.completed)
    return Disposables.create()
}

let subscription = myFirstObservable.subscribe { event in
    switch event {
    case .next(let element):
        print(element)
    case .error(let element):
        print(element)
    case .completed:
        print("comp")
    }
}

subscription.dispose()


struct SearchResult {
    let repos: [GithubRepository]
    let totalCount: Int
    init?(response: Any) {
        guard let response = response as? [String: Any],
            let reposDictonaries = response["items"] as? [[String: Any]],
            let count = response["total_count"] as? Int
            else { return nil }

        repos = reposDictonaries.flatMap { GithubRepository(dictionary: $0) }
        totalCount = count
    }
}

struct GithubRepository {
    let name: String
    let startCount: Int
    init(dictionary: [String: Any]) {
        name = dictionary["fullName"] as! String
        startCount = dictionary["start_count"] as! Int
    }
}
