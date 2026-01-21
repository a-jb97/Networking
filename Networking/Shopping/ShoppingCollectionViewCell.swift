//
//  ShoppingCollectionViewCell.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import UIKit
import SnapKit

class ShoppingCollectionViewCell: UICollectionViewCell {
    static let identifier = "ShoppingCollectionViewCell"
    
    let productImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .accent
        
        return imageView
    }()
    let likeButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .black
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        
        return button
    }()
    let mallNameLabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    let titleLabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 2
        
        return label
    }()
    let priceLabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShoppingCollectionViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(productImageView.snp.width)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(productImageView.snp.trailing).inset(8)
            make.bottom.equalTo(productImageView.snp.bottom).inset(8)
            make.width.height.equalTo(40)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .white
    }
}
