//
//  BoxOfficeTableViewCell.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit
import SnapKit

class BoxOfficeTableViewCell: BaseTableViewCell {
    let rankLabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 17)
        label.backgroundColor = .black
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        
        return label
    }()
    let movieTitleLabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 17)
        
        return label
    }()
    let dateLabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func configureLayout() {
        rankLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.width.equalTo(rankLabel.snp.height).multipliedBy(1.2)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(16)
            make.width.equalTo(contentView.safeAreaLayoutGuide).dividedBy(2)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
    }
}
