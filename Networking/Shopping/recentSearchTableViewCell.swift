//
//  recentSearchTableViewCell.swift
//  Networking
//
//  Created by 전민돌 on 1/22/26.
//

import UIKit
import SnapKit

class recentSearchTableViewCell: UITableViewCell {
    static let identifier = "recentSearchTableViewCell"
    
    var buttonTap: (() -> Void)?
    
    let recentSearchLabel = {
        let label = UILabel()
        
        label.text = "최근 검색어"
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 17)
        
        return label
    }()
    let allDeleteButton = {
        let button = UIButton()
        
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)

        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        allDeleteButton.addTarget(self, action: #selector(allDeleteButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func allDeleteButtonTapped() {
        buttonTap?()
    }
}

extension recentSearchTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(recentSearchLabel)
        contentView.addSubview(allDeleteButton)
    }
    
    func configureLayout() {
        recentSearchLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        allDeleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .white
    }
}
