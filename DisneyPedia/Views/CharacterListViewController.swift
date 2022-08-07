//
//  CharacterListViewController.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import UIKit

class CharacterListViewController: UIViewController, BindableType {

    @IBOutlet private weak var greetingLbl: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var characterListCollectionView: UICollectionView!
    
    private let numberOfColumns = CGFloat(2)
    private let collectionInsets = CGFloat(10)
    private let collectionSideConstraints = CGFloat(32)
    private let screenWidth = UIScreen.main.bounds.width
    
    var viewModel: CharacterListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        characterListCollectionView.delegate = self
        characterListCollectionView.dataSource = self
        characterListCollectionView.register(CharacterCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }

    func bindViewModel() {
        
    }

}


extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier,
                                                                     for: indexPath) as? CharacterCollectionViewCell else {
            fatalError()
        }
        
        characterCell.layoutIfNeeded()
        return characterCell
    }
    
    
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth - collectionSideConstraints - (numberOfColumns - 1) * collectionInsets
        let cellWidth = (width / numberOfColumns)
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
