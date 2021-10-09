//
//  CellConfigurator.swift
//  GithubSearch
//
//  Created by Eido Goya on 2021/10/09.
//

import UIKit
import RxSwift
import RxCocoa

protocol CellConfiguratorProtocol {
    
    associatedtype T: Codable
    var data: T { get }
    
    var reuseIdentifier: String { get }
    
}

class TableCellConfigurator<T: Codable, VM: ViewModelProtocol>: CellConfiguratorProtocol {
    
    var data: T
    var reuseIdentifier: String

    var cell: UITableViewCell
    
    var viewModel: VM
    
    init(data: T,
         reuseIdentifier: String,
         cell: UITableViewCell,
         viewModel: VM) {
        self.data = data
        self.reuseIdentifier = reuseIdentifier
        self.cell = cell
        self.viewModel = viewModel
    }
}


protocol ViewModelProtocol {
    
    associatedtype InputProtocol
    associatedtype OutputProtocol
    
    var inputs: InputProtocol { get }
    var outputs: OutputProtocol { get }
}

protocol SomeViewModelInputs {
    var tapped: BehaviorRelay<Void> { get }
}

protocol SomeViewModelOutputs {
    var dataLoaded: Single<String> { get }
}

class SomeViewModel: ViewModelProtocol,
                     SomeViewModelInputs,
                     SomeViewModelOutputs {
    
    var inputs: SomeViewModelInputs { return self }
    var outputs: SomeViewModelOutputs { return self }
    
    let disposeBag = DisposeBag()
    
    var tapped = BehaviorRelay<Void>(value: ())
    
    var dataLoaded: Single<String>
    
    init() {
        
        tapped.asObservable()
            .bind(onNext: {
                
            })
            .disposed(by: disposeBag)
        
        dataLoaded = Single.create(subscribe: { single -> Disposable in
            
            return Disposables.create {
            }
        })
    }
    
    
}
