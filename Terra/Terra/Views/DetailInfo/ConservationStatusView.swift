//
//  ConservationStatusView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/21/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class ConservationStatusView: UIView {
    //MARK: -- UI Element Initialization
    
    private lazy var redListImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: species.population.conservationStatus.rawValue)
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .clear
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var conservationStatusLabel: UILabel = {
        return Factory.makeLabel(title: species.population.conservationStatus.rawValue,
                                 weight: .medium,
                                 size: 18,
                                 color: .white,
                                 alignment: .center)
    }()
    

    
    //MARK: -- Properties
    private var species: Species
    
    //MARK: -- Methods
    
    private func setBottomConstraint() {
          if let lastSubview = subviews.last {
              bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: Constants.spacingConstant).isActive = true
          }
      }
    
    required init(species: Species) {
        self.species = species
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
        setBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- Add Subviews & Constraints

extension ConservationStatusView {
    func addSubviews() {
        addSubview(redListImage)
        addSubview(conservationStatusLabel)
    }
    
    func setConstraints() {
        setRedListImageConstraints()
        setConservationStatusLabel()
    }
    
    func setRedListImageConstraints() {
        redListImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    func setConservationStatusLabel() {
        conservationStatusLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(redListImage)
            make.height.equalTo(20)
            make.top.equalTo(redListImage.snp.bottom).offset(20)
        }
    }
}
