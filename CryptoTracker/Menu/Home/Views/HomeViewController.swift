//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Anang Nugraha on 21/09/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.reuseIdentifier)
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.reuseIdentifier, for: indexPath) as! CryptoTableViewCell
        cell.textLabel?.text = "Test \(indexPath.row)"
        return cell
    }
    
    
}