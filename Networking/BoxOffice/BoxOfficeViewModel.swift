//
//  BoxOfficeViewModel.swift
//  Networking
//
//  Created by 전민돌 on 2/25/26.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let dateKeyword: ControlProperty<String>
        let searchButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let boxOfficeItems: Driver<[DailyBoxOffice]>
        let errorMessage: PublishSubject<String>
    }
    
    func transform(input: Input) -> Output {
        let boxOfficeItems: BehaviorRelay<[DailyBoxOffice]> = BehaviorRelay(value: [])
        let errorMessage: PublishSubject<String> = PublishSubject()
        
        input.searchButtonTap
            .withLatestFrom(input.dateKeyword)
            .flatMap { keyword in
                if self.isValidDateFormat(text: keyword) {
                    return CustomObservable.singleBoxOfficeRequest(date: keyword)
                } else {
                    errorMessage.onNext("날짜 형식에 맞게 입력해주세요 (yyyyMMdd)")
                    return Single<Result<[DailyBoxOffice], BoxOfficeNetworkError>>.never()
                }
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    boxOfficeItems.accept(value)
                case .failure(let error):
                    errorMessage.onNext(error.description)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(boxOfficeItems: boxOfficeItems.asDriver(), errorMessage: errorMessage)
    }
    
    private func isValidDateFormat(text: String) -> Bool {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.date(from: text) != nil
    }
}
