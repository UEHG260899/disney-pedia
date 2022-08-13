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
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameTileLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    // Should be hidden by default to work properly
    @IBOutlet weak var filmsTitleLabel: UILabel!
    @IBOutlet weak var filmsTextView: UITextView!
    @IBOutlet weak var shortsTitleLabel: UILabel!
    @IBOutlet weak var shortsTextView: UITextView!
    @IBOutlet weak var tvShowsTitleLabel: UILabel!
    @IBOutlet weak var tvShowsTextView: UITextView!
    @IBOutlet weak var videoGamesTitleLabel: UILabel!
    @IBOutlet weak var videoGamesTextView: UITextView!
    @IBOutlet weak var attractionsTitleLabel: UILabel!
    @IBOutlet weak var attractionsTextView: UITextView!
    
    private var disposeBag = DisposeBag()
    var viewModel: CharacterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupImage()
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
    
    private func setupImage() {
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
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
            .drive(self.rx.title, characterNameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel
            .shouldHideFilms
            .drive(filmsTitleLabel.rx.isHidden, filmsTextView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel
            .films
            .drive(onNext: { [weak self] films in
                
                guard let self = self else {
                    return
                }
                
                self.display(films, in: self.filmsTextView)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .shouldHideShortFilms
            .drive(shortsTitleLabel.rx.isHidden, shortsTextView.rx.isHidden)
            .disposed(by: disposeBag)
                
        viewModel
            .shortFilms
            .drive(onNext: { [weak self] shortFilms in
                guard let self = self else {
                    return
                }
                
                self.display(shortFilms, in: self.shortsTextView)
            })
            .disposed(by: disposeBag)
        
        
        viewModel
            .shouldHideTvShows
            .drive(tvShowsTextView.rx.isHidden, tvShowsTitleLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .tvShows
            .drive(onNext: { [weak self] tvShows in
                guard let self = self else {
                    return
                }
                
                self.display(tvShows, in: self.tvShowsTextView)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .shouldHideVideoGames
            .drive(videoGamesTitleLabel.rx.isHidden, videoGamesTextView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .videoGames
            .drive(onNext: { [weak self] videoGames in
                guard let self = self else {
                    return
                }
                
                self.display(videoGames, in: self.videoGamesTextView)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .shouldHideAttractions
            .drive(attractionsTitleLabel.rx.isHidden, attractionsTextView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel
            .attractions
            .drive(onNext: { [weak self] attractions in
                guard let self = self else {
                    return
                }
                
                self.display(attractions, in: self.attractionsTextView)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .imageIsDownloading
            .drive(imageActivityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel
            .characterImage
            .drive(characterImageView.rx.image)
            .disposed(by: disposeBag)

    }
    
    private func display(_ data: [String], in textView: UITextView) {
        var completeString = ""
        textView.text = ""
        
        for (idx, element) in data.enumerated() {
            if idx == data.count - 1 {
                completeString += element
                break
            }
            
            completeString += "\(element), "
        }
        
        textView.text = completeString
    }

}
