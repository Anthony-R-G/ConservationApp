//
//  OverviewSummaryView.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/12/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

class OverviewSummaryView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = Constants.titleLabelColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = """
        People  usually think of leopards in the savannas of Africa but in the Russian Far East, a rare subspecies has adapted to life in the temperate forests that make up the northern-most part of the species’ range. Similar to other leopards, the Amur leopard can run at speeds of up to 37 miles per hour.
        
        This incredible animal has been reported to leap more than 19 feet horizontally and up to 10 feet vertically.  The Amur leopard is solitary. Nimble-footed and strong, it carries and hides unfinished kills so that they are not taken by other predators.
        
        It has been reported that some males stay with females after mating, and may even help with rearing the young. Several males sometimes follow and fight over a female. They live for 10-15 years, and in captivity up to 20 years. The Amur leopard is also known as the Far East leopard, the Manchurian leopard or the Korean leopard.
        
        Not many people ever see an Amur leopard in the wild. Not surprising, as there are so few of them, but a shame considering how beautiful they are. Thick, luscious, black-ringed coats and a huge furry tails they can wrap around themselves to keep warm.
        
        The good news is, having been driven to the edge of extinction, their numbers appear to be rising thanks to conservation work - we're also able to survey more areas than before and use camera traps to estimate population changes.
        
        The Amur leopard is a nocturnal animal that lives and hunts alone – mainly in the vast forests of Russia and China. During the harsh winter, the hairs of that unique coat can grow up to 7cm long.
        
        Over the years the Amur leopard hasn't just been hunted mercilessly, its homelands have been gradually destroyed by unsustainable logging, forest fires, road building, farming, and industrial development.
        
        But recent research shows conservation work is having a positive effect, and wild Amur leopard numbers are believed to have increased, though there are still only around 90 adults in the wild, in Russia and north-east China.
        """
        label.numberOfLines = 0
        return label
    }()
    
    private func setContentViewBottomConstraint() {
        if let lastSubview = subviews.last {
            bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.399026113)
        layer.cornerRadius = 20
        addSubviews()
        setConstraints()
        setContentViewBottomConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension OverviewSummaryView {
    func addSubviews() {
        let UIElements = [titleLabel, bodyLabel]
        UIElements.forEach { addSubview($0) }
        UIElements.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func setConstraints() {
        setTitleLabelConstraints()
        setLabelConstraints()
        
    }
    
    func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setLabelConstraints() {
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
