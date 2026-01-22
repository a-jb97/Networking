//
//  ShoppingDetailViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import UIKit
import SnapKit
import Kingfisher

class ShoppingDetailViewController: UIViewController {
    let totalLabel = {
        let label = UILabel()
        
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
    
    var productList: [ShoppingDetail] = []
    
    enum Sort {
        static let sim = "sim"
        static let date = "date"
        static let asc = "asc"
        static let dsc = "dsc"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        sortAccuracyButton.addTarget(self, action: #selector(sortAccuracyButtonTapped), for: .touchUpInside)
        sortDateButton.addTarget(self, action: #selector(sortDateButtonTapped), for: .touchUpInside)
        sortHighPriceButton.addTarget(self, action: #selector(sortHighPriceButtonTapped), for: .touchUpInside)
        sortLowPriceButton.addTarget(self, action: #selector(sortLowPriceButtonTapped), for: .touchUpInside)
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
    
    @objc private func sortAccuracyButtonTapped() {
        NetworkManager.shared.callRequest(query: navigationItem.title!, start: 1, sort: Sort.sim, type: Shopping.self) { shopping in
            print(#function)
            self.totalLabel.text = "\(shopping.total.formatted()) 개의 검색 결과"
            self.productList = shopping.items
            self.shoppingCollectionView.reloadData()
        }
    }
    
    @objc private func sortDateButtonTapped() {
        NetworkManager.shared.callRequest(query: navigationItem.title!, start: 1, sort: Sort.date, type: Shopping.self) { shopping in
            print(#function)
            self.totalLabel.text = "\(shopping.total.formatted()) 개의 검색 결과"
            self.productList = shopping.items
            self.shoppingCollectionView.reloadData()
        }
    }
    
    @objc private func sortHighPriceButtonTapped() {
        NetworkManager.shared.callRequest(query: navigationItem.title!, start: 1, sort: Sort.dsc, type: Shopping.self) { shopping in
            print(#function)
            self.totalLabel.text = "\(shopping.total.formatted()) 개의 검색 결과"
            self.productList = shopping.items
            self.shoppingCollectionView.reloadData()
        }
    }
    
    @objc private func sortLowPriceButtonTapped() {
        NetworkManager.shared.callRequest(query: navigationItem.title!, start: 1, sort: Sort.asc, type: Shopping.self) { shopping in
            print(#function)
            self.totalLabel.text = "\(shopping.total.formatted()) 개의 검색 결과"
            self.productList = shopping.items
            self.shoppingCollectionView.reloadData()
        }
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        sortAccuracyButton.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
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
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCollectionViewCell.identifier, for: indexPath) as! ShoppingCollectionViewCell
        let intLPrice = Int(productList[indexPath.row].lprice)
        
        item.productImageView.kf.setImage(with: URL(string: productList[indexPath.row].image))
        item.mallNameLabel.text = productList[indexPath.row].mallName
        item.titleLabel.text = productList[indexPath.row].title
        item.priceLabel.text = "\(intLPrice!.formatted())"
        
        return item
    }
}
