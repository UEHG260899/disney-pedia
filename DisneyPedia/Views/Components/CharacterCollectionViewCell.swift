//
//  CharacterCollectionViewCell.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 07/08/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell, ReusableCellType {

    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    
    
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

}
