// SnapKit + Rx で画面を作成する

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import PlaygroundSupport

class VC: UIViewController {
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.backgroundColor = UIColor.red
        button.snp.makeConstraints{ make in
            make.width.height.equalTo(100)
            make.top.left.equalTo(100)
        }
        
        button.rx.tap
            .subscribe(onNext: { _ in
                print("tap")
            })
            .disposed(by: disposeBag)
    }
}

let vc = VC()
vc.title = "title"
let nav = UINavigationController(rootViewController: vc)
nav.view.frame = CGRect(x: 0, y: 0, width: 320, height: 568)

/// MARK: - View を表示

PlaygroundPage.current.liveView = nav
PlaygroundPage.current.needsIndefiniteExecution = true
