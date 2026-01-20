//
//  MainButton.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit

class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.backgroundColor = backgroundColor
        clipsToBounds = true
        layer.cornerRadius = 15
    }
}
