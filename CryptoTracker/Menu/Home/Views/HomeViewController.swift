//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 21/09/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        setupAndBindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCryptos()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupAndBindData() {
        viewModel.state.asObserver().subscribe(onNext: { [weak self ]state in
            switch state{
            case .loading:
                self?.showSpinner(onView: self!.view)
            case .finish:
                self?.removeSpinner()
            default:
                self?.removeSpinner()
            }
        }).disposed(by: disposeBag)
        
        viewModel.cryptos.bind(to: tableView.rx.items(cellIdentifier: CryptoTableViewCell.reuseIdentifier, cellType: CryptoTableViewCell.self)){[weak self] row,element,cell in
            let price = self?.numberFormatter.string(from: NSNumber(floatLiteral: element.priceUsd ?? 0))
            cell.configure(name: element.name ?? "", symbol: element.assetID ?? "", price: price ?? "")
            
        }.disposed(by: disposeBag)
    }
    
}
