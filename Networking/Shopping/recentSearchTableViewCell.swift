//
//  recentSearchTableViewCell.swift
//  Networking
//
//  Created by 전민돌 on 1/22/26.
//

import UIKit
import SnapKit

class recentSearchTableViewCell: UITableViewCell {
    let recentSearchLabel = {
        let label = UILabel()
        
        label.text = "최근 검색어"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17)
        
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
        UserDefaultsManager.searchKeywords?.removeAll()
    }
}

extension recentSearchTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(recentSearchLabel)
        contentView.addSubview(allDeleteButton)
    }
    
    func configureLayout() {
        recentSearchLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        allDeleteButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .white
    }
}
