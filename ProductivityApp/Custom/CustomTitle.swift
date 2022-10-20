//
//  CustomTitle.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/13/22.
//

import UIKit

class CustomTitle: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlingment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlingment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        configure()
    }
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
