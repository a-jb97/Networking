//
//  recentSearchListTableViewCell.swift
//  Networking
//
//  Created by 전민돌 on 1/22/26.
//

import UIKit
import SnapKit

class recentSearchListTableViewCell: UITableViewCell {
    static let identifier = "recentSearchListTableViewCell"
    
    var buttonTap: (() -> Void)?
    
    let magnifyImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .lightGray
        
        return imageView
    }()
    let keywordLabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        
        return label
    }()
    let deleteButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .lightGray
        
        return button
    }()
    
    let row = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func deleteButtonTapped() {
        buttonTap?()
    }
}

extension recentSearchListTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(magnifyImageView)
        contentView.addSubview(keywordLabel)
        contentView.addSubview(deleteButton)
    }
    
    func configureLayout() {
        magnifyImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(20)
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(magnifyImageView.snp.trailing).offset(16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .white
    }
}
