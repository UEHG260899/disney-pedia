//
//  CharacterCollectionViewCell.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterCollectionViewCell: UICollectionViewCell, ReusableCellType, BindableType {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    var viewModel: CharacterCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
    }
    
    private func setupUI() {
        bottomView.layer.cornerRadius = 12
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 5
    }
        
    func bindViewModel() {
        viewModel.taskIsRunning
            .drive(characterImageView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.taskIsRunning
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.imageDownLoader
            .observe(on: MainScheduler.instance)
            .bind(to: characterImageView.rx.image)
            .disposed(by: disposeBag)
        
        characterNameLabel.text = viewModel.characterName
    }

}
