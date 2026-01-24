//
//  BoxOfficeViewController.swift
//  Networking
//
//  Created by 전민돌 on 1/20/26.
//

import UIKit
import SnapKit
import Alamofire

class BoxOfficeViewController: BaseViewController {
    let dateTextField = {
        let textField = UITextField()
        
        textField.placeholder = "날짜를 입력해주세요(ex : 20200401)"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    let searchButton = MainButton(title: "검색", backgroundColor: .black)

    var boxOfficeList: [DailyBoxOffice] = []
    
    lazy var boxOfficeTableView = {
        let tableView = UITableView()
        
        tableView.rowHeight = 70
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        
        return tableView
    }()
    
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
        
        callRequest(date: previousDate)
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc private func searchButtonTapped() {
        callRequest(date: dateTextField.text!)
    }
    
    private func callRequest(date: String) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=3d21e6069bf78850c738916d85c1cbe0&targetDt=\(date)"
        
        AF.request(url, method: .get).responseDecodable(of: BoxOfficeResponse.self) { response in
            switch response.result {
            case .success(let value):
                self.boxOfficeList = value.boxOfficeResult.dailyBoxOfficeList
                self.boxOfficeTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell
        
        cell.rankLabel.text = boxOfficeList[indexPath.row].rank
        cell.movieTitleLabel.text = boxOfficeList[indexPath.row].movieNm
        cell.dateLabel.text = boxOfficeList[indexPath.row].openDt
        
        return cell
    }
}
