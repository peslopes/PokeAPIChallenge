//
//  ViewControllerViewCode.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 26/06/22.
//

import Foundation
import UIKit

protocol ViewControllerViewCodeContract: UIViewController {
    func buildViewHierarchy()
    
    func setupConstraints()

    func configureViews()

    func configureNavBar()
    
    func configureLayout()
}

extension ViewControllerViewCodeContract {
    func configureLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
        configureNavBar()
    }
}
