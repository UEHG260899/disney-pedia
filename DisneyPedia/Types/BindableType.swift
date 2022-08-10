//
//  BindableType.swift
//  DisneyPedia
//
//  Created by Uriel Hernandez Gonzalez on 06/08/22.
//

import UIKit

protocol BindableType: AnyObject {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}


extension BindableType where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension BindableType where Self: UICollectionViewCell {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}
