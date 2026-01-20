//
//  ViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let randomImageButton = MainButton(title: "랜덤 이미지", backgroundColor: .systemBlue)
    let boxOfficeButton = MainButton(title: "박스오피스", backgroundColor: .systemBrown)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension ViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(randomImageButton)
        view.addSubview(boxOfficeButton)
    }
    
    func configureLayout() {
        randomImageButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
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
    
    func configureView() {
        view.backgroundColor = .white
    }
}
