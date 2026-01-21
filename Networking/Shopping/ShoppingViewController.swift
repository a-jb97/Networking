//
//  ShoppingViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import UIKit
import SnapKit
import Alamofire

class ShoppingViewController: UIViewController {
    let shoppingSearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
        
        shoppingSearchBar.delegate = self
    }
}

extension ShoppingViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(shoppingSearchBar)
    }
    
    func configureLayout() {
        shoppingSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        navigationItem.title = "도봉러의 쇼핑쇼핑"
    }
}

extension ShoppingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = ShoppingDetailViewController()
        
        if searchBar.text!.count >= 2 {
            vc.navigationItem.title = searchBar.text
            
            NetworkManager.shared.callRequest(query: searchBar.text!, start: 1, sort: "sim", type: Shopping.self) { shopping in
                print(#function)
                vc.totalLabel.text = "\(shopping.total.formatted()) 개의 검색 결과"
                vc.productList = shopping.items
                vc.shoppingCollectionView.reloadData()
            }
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
