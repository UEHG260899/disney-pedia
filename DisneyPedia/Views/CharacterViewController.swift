//
//  CharacterViewController.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 10/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterViewController: UIViewController, BindableType {

    @IBOutlet weak var testLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    var viewModel: CharacterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.backward")!, style: .done, target: self, action: #selector(onClickedBack))
        navigationItem.setLeftBarButton(button, animated: false)
    }
    
    @objc
    private func onClickedBack() {
        viewModel.coordinator.pop()
    }

    func bindViewModel() {
        viewModel
            .character
            .map(\.name)
            .drive(testLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
