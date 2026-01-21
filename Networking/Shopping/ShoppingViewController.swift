//
//  ShoppingViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/21/26.
//

import UIKit
import SnapKit

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
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
