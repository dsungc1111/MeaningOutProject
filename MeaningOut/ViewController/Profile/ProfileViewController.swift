//
//  ProfileSettingViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

class ProfileViewController: UIViewController {    
    lazy var profileButton = {
        let button = CustomProfileButton()
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    let profileCameraLogo = {
        let logo = CameraLogo(frame: .zero)
        return logo
    }()
    lazy var nicknameTextfield = {
        let nickname = UITextField()
        nickname.font = .systemFont(ofSize: 13)
        nickname.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        nickname.leftViewMode = .always
        nickname.placeholder = "닉네임을 입력해주세요 :)"
        nickname.addTarget(self, action: #selector(nicknameDidChange), for: .editingChanged)
        return nickname
    }()
    let warningTextfield = {
        let warning = UITextField()
        warning.text = WarningMessage.basic.rawValue
        warning.textColor = UIColor.mainColor
        warning.font = .systemFont(ofSize: 13)
        return warning
    }()
    lazy var completeButton = {
        let button = BigSizeButton()
        button.setTitle("Complete", for: .normal)
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        completeButton.isEnabled = false
    }
    override func viewDidLayoutSubviews() {
        profileButton.layer.cornerRadius = profileButton.frame.width / 2
        profileCameraLogo.layer.cornerRadius = profileCameraLogo.frame.width/2
        nicknameTextfield.layer.addBorder([.bottom], color: .lightGray, width: 1)
        navigationController?.navigationBar.layer.addBorder([.bottom], color: .systemGray4, width: 1)
        profileButton.setImage(UIImage(named: UserDefaultManager.profileImage), for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        profileButton.setImage(UIImage(named: UserDefaultManager.profileImage), for: .normal)
    }
    @objc func nicknameDidChange() {
        guard let text = nicknameTextfield.text else {
            return
        }
        if text.count >= 2 && text.count < 10 {
            warningTextfield.text = WarningMessage.pass.rawValue
            if text.contains(SpecialCharacters.hashSymbol.rawValue) || text.contains(SpecialCharacters.atTheRateSignSymbol.rawValue) || text.contains(SpecialCharacters.dollarSymbol.rawValue) || text.contains(SpecialCharacters.percentSymbol.rawValue) {
                warningTextfield.text = WarningMessage.specialCharactersFail.rawValue
            }
            if text.contains(SpecialCharacters.blankSymbol.rawValue) {
                warningTextfield.text = WarningMessage.blankFail.rawValue
            }
            for i in String().number {
                if text.contains(i)  {
                    warningTextfield.text = WarningMessage.numberFail.rawValue
                }
            }
        } else {
            warningTextfield.text = WarningMessage.countFail.rawValue
        }
        
        if warningTextfield.text == WarningMessage.pass.rawValue {
            completeButton.isEnabled = true
        } else {
            completeButton.isEnabled = false
        }
        
    }
    @objc func profileButtonTapped() {
        let vc = SelectViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        vc.navigationItem.title = "PROFILE SETTING"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func completeButtonTapped() {
        getDateString()
        UserDefaultManager.user = nicknameTextfield.text ?? "nil XX"
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = TabBarController()
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    func getDateString() {
        let toString = Variable.dateFormatter
        toString.dateFormat = "MM/dd/yy HH:mm"
        let convertNowStr = toString.string(from: Date())
        UserDefaultManager.signInTime = convertNowStr
    }
    func configureHierarchy() {
        view.addSubview(profileButton)
        view.addSubview(profileCameraLogo)
        view.addSubview(nicknameTextfield)
        view.addSubview(warningTextfield)
        view.addSubview(completeButton)
    }
    func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(100)
        }
        profileCameraLogo.snp.makeConstraints { make in
            make.bottom.equalTo(profileButton.snp.bottom).inset(10)
            make.trailing.equalTo(profileButton.snp.trailing)
            make.size.equalTo(30)
        }
        nicknameTextfield.snp.makeConstraints { make in
            make.top.equalTo(profileCameraLogo.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(60)
        }
        warningTextfield.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextfield.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(warningTextfield.snp.bottom).offset(25)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
}
