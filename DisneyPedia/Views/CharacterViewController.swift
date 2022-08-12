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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameTileLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    // Should be hidden by default to work properly
    @IBOutlet weak var filmsTitleLabel: UILabel!
    @IBOutlet weak var filmsStackView: UIStackView!
    
    
    private var disposeBag = DisposeBag()
    var viewModel: CharacterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavBar()
    }
    
    private func setupUI() {
        cardView.layer.cornerRadius = 16
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func configureNavBar() {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.backward")!, style: .done, target: self, action: #selector(onClickedBack))
        navigationItem.setLeftBarButton(button, animated: false)
    }
    
    @objc
    private func onClickedBack() {
        viewModel.coordinator.pop()
    }

    func bindViewModel() {
        
        viewModel
            .taskIsRunning
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        
        viewModel
            .taskIsRunning
            .drive(characterNameTileLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .taskIsRunning
            .drive(characterNameLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .character
            .map(\.name)
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel
            .character
            .map(\.name)
            .drive(characterNameLabel.rx.text)
            .disposed(by: disposeBag)
                
        viewModel
            .shouldHideFilms
            .drive(filmsTitleLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .shouldHideFilms
            .drive(filmsStackView.rx.isHidden)
            .disposed(by: disposeBag)

    }

}
