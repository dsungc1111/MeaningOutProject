//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/14/24.
//

import UIKit

enum SettingMenu: String, CaseIterable {
    case myBasket = "나의 장바구니 목록"
    case question = "자주 묻는 질문"
    case inquiry = "1:1 문의"
    case notificationSetting = "알림 설정"
    case withdraw = "탈퇴하기"
}


class SettingViewController: UIViewController {
    
    let tableView = UITableView()
    
    lazy var profileButton = {
        let button = CustomProfileButton()
        return button
    }()
    let userNickname = {
        let label = UILabel()
        label.text = Variable.user
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    let signInDate = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "가입"
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        configureHierarchy()
        configureLayout()
    }
    
    override func viewDidLayoutSubviews() {
        profileButton.layer.cornerRadius = profileButton.frame.width / 2
       navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
        profileButton.setImage(UIImage(named: Variable.profileImage), for: .normal)
        tableView.layer.addBorder([.top], color: .systemGray4, width: 1)
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        profileButton.setImage(UIImage(named: Variable.profileImage), for: .normal)
        userNickname.text = Variable.user
        tableView.reloadData()
    }
    
    @objc func editButtonTapped() {
        let vc  = EditViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
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
        
//        cell.settingButton.addTarget(self, action: #selector(resetButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50// 원하는 셀 높이 설정
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 4 {
            let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴하시겠습니까?", preferredStyle: .actionSheet)
            
            let okButton = UIAlertAction(title: "확인", style: .default) {_ in 
                Variable.user = ""
                Variable.profileImage = ""
                
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
