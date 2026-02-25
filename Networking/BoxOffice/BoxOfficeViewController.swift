//
//  BoxOfficeViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit
import SnapKit
import Alamofire
import RxSwift
import RxCocoa

class BoxOfficeViewController: BaseViewController {
    let dateTextField = {
        let textField = UITextField()
        
        textField.placeholder = "날짜를 입력해주세요(ex : 20200401)"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    let searchButton = MainButton(title: "검색", backgroundColor: .black)

    var boxOfficeList: [DailyBoxOffice] = []
    
    private let boxOfficeTableView = {
        let tableView = UITableView()
        
        tableView.rowHeight = 70
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        return tableView
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = BoxOfficeViewModel()
    
    // MARK: 어제 날짜
    let previousDate = {
        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let format = DateFormatter()
        
        format.dateFormat = "yyyyMMdd"
        
        let convertPreviousDay = format.string(from: previousDay)
        
        return convertPreviousDay
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "박스오피스"
        
        bind()
    }
    
    func bind() {
        let input = BoxOfficeViewModel.Input(dateKeyword: dateTextField.rx.text.orEmpty, searchButtonTap: searchButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.boxOfficeItems
            .drive(boxOfficeTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as! BoxOfficeTableViewCell
                
                cell.rankLabel.text = element.rank
                cell.movieTitleLabel.text = element.movieNm
                cell.dateLabel.text = element.openDt
                
                return cell
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .bind(with: self) { owner, message in
                owner.showAlert(message: message)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(dateTextField)
        view.addSubview(searchButton)
        view.addSubview(boxOfficeTableView)
    }
    
    override func configureLayout() {
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(dateTextField.snp.width).dividedBy(5)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(dateTextField.snp.trailing).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(dateTextField.snp.height)
        }
        
        boxOfficeTableView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
