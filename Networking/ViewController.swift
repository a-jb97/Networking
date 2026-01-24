//
//  ViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit
import SnapKit

class ViewController: BaseViewController {
    let randomImageButton = MainButton(title: "랜덤 이미지", backgroundColor: .systemBlue)
    let boxOfficeButton = MainButton(title: "박스오피스", backgroundColor: .systemBrown)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomImageButton.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchUpInside)
        boxOfficeButton.addTarget(self, action: #selector(boxOfficeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func randomImageButtonTapped() {
        let vc = RandomImageViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func boxOfficeButtonTapped() {
        let vc = BoxOfficeViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(randomImageButton)
        view.addSubview(boxOfficeButton)
    }
    
    override func configureLayout() {
        randomImageButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        
        boxOfficeButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(randomImageButton.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
}
