//
//  ShoppingDetailViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class ShoppingDetailViewController: UIViewController {
    let totalLabel = {
        let label = UILabel()
        
        label.text = "13,2344234 개의 검색 결과"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .accent
        
        return label
    }()
    
    let sortAccuracyButton = SortButton(title: "정확도")
    let sortDateButton = SortButton(title: "날짜순")
    let sortHighPriceButton = SortButton(title: "가격높은순")
    let sortLowPriceButton = SortButton(title: "가격낮은순")
    
    lazy var shoppingCollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ShoppingDetailViewController.layout())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 16
        let spacing: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width
        
        let totalInset = inset * 2
        let totalSpacing = spacing
        let itemWidth = (screenWidth - totalInset - totalSpacing) / 2
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        
        return layout
    }
}

extension ShoppingDetailViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(sortAccuracyButton)
        view.addSubview(sortDateButton)
        view.addSubview(sortHighPriceButton)
        view.addSubview(sortLowPriceButton)
        view.addSubview(shoppingCollectionView)
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(8)
        }
        
        sortAccuracyButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(40)
        }
        
        sortDateButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.leading.equalTo(sortAccuracyButton.snp.trailing).offset(8)
            make.height.equalTo(40)
        }
        
        sortHighPriceButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.leading.equalTo(sortDateButton.snp.trailing).offset(8)
            make.height.equalTo(40)
        }
        
        sortLowPriceButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.leading.equalTo(sortHighPriceButton.snp.trailing).offset(8)
            make.height.equalTo(40)
        }
        
        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sortAccuracyButton.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}

extension ShoppingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCollectionViewCell.identifier, for: indexPath) as! ShoppingCollectionViewCell
        
        return item
    }
}
