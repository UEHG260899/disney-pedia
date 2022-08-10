//
//  CharacterListViewController.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var greetingLbl: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var characterListCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let numberOfColumns = CGFloat(2)
    private let collectionInsets = CGFloat(10)
    private let collectionSideConstraints = CGFloat(32)
    private let screenWidth = UIScreen.main.bounds.width
    private var disposeBag = DisposeBag()
    
    var viewModel: CharacterListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        characterListCollectionView.delegate = self
        characterListCollectionView.register(CharacterCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
    
    func bindViewModel() {
        
        viewModel.greeting
            .drive(greetingLbl.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.characterList
            .observe(on: MainScheduler.instance)
            .bind(to: characterListCollectionView.rx.items(cellIdentifier: CharacterCollectionViewCell.identifier, cellType: CharacterCollectionViewCell.self)) { row, model, cell in
                let cellViewModel = CharacterCellViewModel(characterListService: self.viewModel.characterListService, name: model.name, imageUrl: model.imageUrl ?? "")
                cell.bindViewModel(to: cellViewModel)
                cell.layoutIfNeeded()
            }.disposed(by: disposeBag)
        
        viewModel.taskIsRunning
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.taskIsRunning
            .drive(characterListCollectionView.rx.isHidden)
            .disposed(by: disposeBag)

        searchTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .map { [weak self] _ in self?.searchTextField.text ?? "" }
            .filter { !$0.isEmpty }
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        _ = viewModel
            .searchText
            .flatMap { [weak self] _ -> Observable<[DisneyCharacter]> in
                
                guard let self = self else {
                    return Observable.of([])
                }
                
                return self.viewModel.characterListService.characters(page: Int.random(in: 1...149))
                    .flatMap { Observable.from(optional: $0.data) }
            }
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.characterListRelay.accept(value)
            })

    }
    
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth - collectionSideConstraints - (numberOfColumns - 1) * collectionInsets
        let cellWidth = (width / numberOfColumns)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
