//
//  LilYuuTableViewController.swift
//  YunDingDemo
//
//  Created by 张青木 on 2023/11/17.
//

import UIKit

class LilYuuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds,style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Table view data source
//    组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return LineupNu!.count
    }
    
//    每组多少个格子
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return LineupNu![section].count
        
    }
    
//    组名
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return LineupNu![section].Attribute
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var dataName = LineupNu![indexPath.section].Attribute
        let filteredData = Lineups!.filter { $0.Attribute == dataName }
        
        
        cell.textLabel?.text = filteredData[indexPath.row].Description
//        data[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var dataName = LineupNu![indexPath.section].Attribute
        let filteredData = Lineups!.filter { $0.Attribute == dataName }
        let data = filteredData[indexPath.row].Description
        
        print("You selected:\(data)")
        
        let zhenRongViewController = ZhenRongViewController()
        
        zhenRongViewController.selectedZhenRong = data
        zhenRongViewController.comId = filteredData[indexPath.row].id
        
        navigationController?.pushViewController(zhenRongViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
