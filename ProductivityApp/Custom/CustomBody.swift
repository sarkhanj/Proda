//
//  CustomBody.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/14/22.
//

import UIKit


class CustomBody: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlingment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlingment
        configure()
    }
    
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }

}
