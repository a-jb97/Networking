//
//  RandomImageViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class RandomImageViewController: UIViewController {
    let randomImageLoadButton = MainButton(title: "랜덤 이미지 불러오기", backgroundColor: .systemBlue)
    let randomImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    let authorLabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    let resolutionLabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        randomImageLoadButton.addTarget(self, action: #selector(randomImageLoadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func randomImageLoadButtonTapped() {
        let url = "https://picsum.photos/id/\(Int.random(in: 1...100))/info"
        
        AF.request(url, method: .get).responseDecodable(of: Picsum.self) { response in
            switch response.result {
            case .success(let value):
                self.randomImageView.kf.setImage(with: URL(string: value.download_url))
                self.authorLabel.text = value.author
                self.resolutionLabel.text = "해상도 : \(value.width) x \(value.height)"
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RandomImageViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(randomImageLoadButton)
        view.addSubview(randomImageView)
        view.addSubview(authorLabel)
        view.addSubview(resolutionLabel)
    }
    
    func configureLayout() {
        randomImageLoadButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
            make.width.equalTo(randomImageLoadButton.snp.height).multipliedBy(4)
        }
        
        randomImageView.snp.makeConstraints { make in
            make.top.equalTo(randomImageLoadButton.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(randomImageView.snp.width).dividedBy(1.5)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(randomImageView.snp.bottom).offset(60)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        resolutionLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}
