//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 21/09/21.
//

import UIKit
import RxSwift
import SkeletonView

class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.isSkeletonable = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAndBindData()
        view.addSubview(tableView)
        view.isSkeletonable = true
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
                self?.view.showAnimatedGradientSkeleton()
            case .finish:
                self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            default:
                self?.tableView.hideSkeleton()
            }
        }).disposed(by: disposeBag)
        
        viewModel.cryptos.subscribe(onNext: { [weak self] cryptos in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
}

extension HomeViewController: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCyrptoItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.reuseIdentifier, for: indexPath) as! CryptoTableViewCell
        viewModel.configureCryptoCell(cell, indexPath)
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CryptoTableViewCell.reuseIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    
    
    
}
