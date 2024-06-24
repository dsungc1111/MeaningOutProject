//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit


class SettingViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var profileButton = {
        let button = CustomProfileButton()
        return button
    }()
    let userNickname = {
        let label = UILabel()
        label.text = UserDefaultManager.user
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let signInDate = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "\(UserDefaultManager.signInTime)에 가입"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    lazy var editButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.tintColor = .black
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Setting"
        tableViewSetting()
        configureHierarchy()
        configureLayout()
    }
    
    
    override func viewDidLayoutSubviews() {
        profileButton.layer.cornerRadius = profileButton.frame.width / 2
       navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
        profileButton.setImage(UIImage(named: UserDefaultManager.profileImage), for: .normal)
        tableView.layer.addBorder([.top], color: .systemGray4, width: 1)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        profileButton.setImage(UIImage(named: UserDefaultManager.profileImage), for: .normal)
        userNickname.text = UserDefaultManager.user
        tableView.reloadData()
    }
    @objc func editButtonTapped() {
        let vc  = EditViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
    
    func configureHierarchy() {
        view.addSubview(profileButton)
        view.addSubview(tableView)
        view.addSubview(userNickname)
        view.addSubview(signInDate)
        view.addSubview(editButton)
    }
    func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(100)
        }
        tableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(160)
        }
        userNickname.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.leading.equalTo(profileButton.snp.trailing).offset(15)
        }
        signInDate.snp.makeConstraints { make in
            make.top.equalTo(userNickname.snp.bottom).offset(5)
            make.leading.equalTo(profileButton.snp.trailing).offset(15)
        }
        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(tableView.snp.top)
        }
    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return SettingTableViewCell() }
        cell.settingButton.tag = indexPath.row
        cell.configureCell(data: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = BasketViewController()
            navigationController?.navigationBar.tintColor = .black
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            vc.navigationItem.title = "장바구니 목록"
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4 {
            let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴하시겠습니까?", preferredStyle: .actionSheet)
            let okButton = UIAlertAction(title: "확인", style: .default) {_ in
                
                for i in 0..<Variable.mySearch.count {
                    UserDefaults.standard.setValue(false, forKeyPath: "\(Variable.mySearch[i].title)")
                }
                UserDefaultManager.user = ""
                UserDefaultManager.profileImage = ""
                UserDefaultManager.searchList = []
                UserDefaultManager.myBasket = []
                let vc = UINavigationController(rootViewController: OnBoardingViewController())
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            let cancelButton = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancelButton)
            alert.addAction(okButton)
            present(alert, animated: true)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}

