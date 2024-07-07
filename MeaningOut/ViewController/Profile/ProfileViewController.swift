//
//  ProfileSettingViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private static var dateFormatter = DateFormatter()
    
    private lazy var profileButton = {
        let button = CustomProfileButton()
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    private let profileCameraLogo = {
        let logo = CameraLogo(frame: .zero)
        return logo
    }()
    private lazy var nicknameTextfield = {
        let nickname = UITextField()
        nickname.font = .systemFont(ofSize: 13)
        nickname.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0.0))
        nickname.leftViewMode = .always
        nickname.placeholder = "닉네임을 입력해주세요 :)"
        nickname.addTarget(self, action: #selector(nicknameDidChange), for: .editingChanged)
        return nickname
    }()
    private let warningTextfield = {
        let warning = UITextField()
        warning.text = WarningMessage.basic.rawValue
        warning.textColor = UIColor.mainColor
        warning.font = .systemFont(ofSize: 13)
        return warning
    }()
    private lazy var completeButton = {
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
        guard let text = nicknameTextfield.text else { return }
        confirmNickname(text: text)
        
    }
    @objc func profileButtonTapped() {
        let vc = SelectViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        vc.navigationItem.title = "PROFILE SETTING"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func completeButtonTapped() {
        UserDefaultManager.signInTime = DateChange.shared.dateToString(date: Date())
        UserDefaultManager.user = nicknameTextfield.text ?? "nil XX"

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = TabBarController()
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    private func nicknameCheck(text: String) throws -> String {
        guard text.count >= 2 else {
            throw LoginError.short
        }
        guard text.count < 10 else {
            throw LoginError.long
        }
        guard !text.contains(SpecialCharacters.hashSymbol.rawValue) &&
                !text.contains(SpecialCharacters.atTheRateSignSymbol.rawValue) &&
                !text.contains(SpecialCharacters.dollarSymbol.rawValue) &&
                !text.contains(SpecialCharacters.percentSymbol.rawValue) else {
            throw LoginError.specialCharacters
        }
        for i in String().number {
            guard !text.contains(i) else {
                throw LoginError.number
            }
        }
        guard !text.contains(SpecialCharacters.blankSymbol.rawValue) else {
            throw LoginError.blank
        }
        
        return WarningMessage.pass.rawValue
    }
    
    private func confirmNickname(text: String) {
        do {
            let warningMessage = try nicknameCheck(text: text)
            warningTextfield.text = warningMessage
            completeButton.isEnabled = true
        } catch LoginError.blank {
            warningTextfield.text = WarningMessage.blankFail.rawValue
        } catch LoginError.long {
            warningTextfield.text = WarningMessage.countFail.rawValue
        } catch LoginError.short {
            warningTextfield.text = WarningMessage.countFail.rawValue
        } catch LoginError.number {
           warningTextfield.text = WarningMessage.numberFail.rawValue
        } catch LoginError.specialCharacters {
            warningTextfield.text = WarningMessage.specialCharactersFail.rawValue
        } catch {
            warningTextfield.text = WarningMessage.exception.rawValue
        }
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
