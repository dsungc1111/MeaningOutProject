//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit
import IQKeyboardManagerSwift

class SearchViewController: UIViewController {
    
    let tableView = UITableView()
    static var resultText: [Int : String] = [:]
    let searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "브랜드, 상품 등을 입력하세요."
        return bar
    }()
    
    let noRecordImage = {
        let image = UIImageView()
        image.image = UIImage(named: "empty")
        image.contentMode = .scaleAspectFill
        return image
    }()
    let noSearchLabel = {
        let label = UILabel()
        label.text = "최근 검색어가 없어요."
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let recentSearch = {
        let label = UILabel()
        label.text = "최근검색"
        label.font = .boldSystemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    lazy var removeAll = {
        let button = UIButton()
        button.setTitle("전체삭제", for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.isHidden = true
        button.addTarget(self, action: #selector(removeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        configureHierarchy()
        configureLayout()
        selectedWindow()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "\(Variable.user)'s Meaning Out"
    }
    
    @objc func removeAllButtonTapped() {
            Variable.searchList.removeAll()
            selectedWindow()
        }
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(noRecordImage)
        view.addSubview(noSearchLabel)
        view.addSubview(recentSearch)
        view.addSubview(removeAll)
        view.addSubview(tableView)
    }
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        noRecordImage.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom).offset(100)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(250)
        }
        noSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(noRecordImage.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
        recentSearch.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        removeAll.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(recentSearch.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func selectedWindow() {
        if Variable.searchList.count == 0 {
            tableView.isHidden = true
            noRecordImage.isHidden = false
            noSearchLabel.isHidden = false
            recentSearch.isHidden = true
            removeAll.isHidden = true
        } else {
            tableView.isHidden = false
            noRecordImage.isHidden = true
            noSearchLabel.isHidden = true
            recentSearch.isHidden = false
            removeAll.isHidden = false
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Variable.searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as?
                SearchResultTableViewCell else { return SearchResultTableViewCell() }
        cell.resultButton.tag = indexPath.row
        
        cell.resultButton.setTitle(Variable.searchList[indexPath.row], for: .normal)
        cell.resultButton.addTarget(self, action: #selector(resultButtonTapped(sender:)), for: .touchUpInside)

        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Variable.searchList.remove(at: indexPath.row)
        selectedWindow()
        tableView.reloadData()
    }
    
    @objc func resultButtonTapped(sender: UIButton) {
        Variable.searchText = Variable.searchList[sender.tag]
        searchBar.text = Variable.searchText
        guard let text = searchBar.text else { return }
        
        for i in 0..<Variable.searchList.count {
            if text == Variable.searchList[i] {
                Variable.searchList.remove(at: i)
                Variable.searchList.insert(text, at: 0)
            }
        }
        let vc = ResultViewController()
        vc.navigationItem.title = Variable.searchText
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(vc, animated: true)
        searchBar.text = nil
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        if text.contains(Constant.SpecialCharacters.blankSymbol.rawValue) {
            searchBar.placeholder = "빈칸 안돼"
        } else {
            if Variable.searchList.count == 0 {
                Variable.searchList.insert(text, at: 0)
            } else {
                for i in 0..<Variable.searchList.count {
                    if text == Variable.searchList[i] {
                        Variable.searchList.remove(at: i)
                       
                        Variable.searchList.insert(text, at: 0)
                    } else {
                        Variable.searchList.insert(text, at: 0)
                        break
                    }
                }
            }
            
            configureNextNavigation()
        }
        searchBar.text = nil
        selectedWindow()
        tableView.reloadData()
    }
    func configureNextNavigation() {
        let vc = ResultViewController()
        Variable.searchText = searchBar.text!
        vc.navigationItem.title = Variable.searchText
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .black
    }
}
