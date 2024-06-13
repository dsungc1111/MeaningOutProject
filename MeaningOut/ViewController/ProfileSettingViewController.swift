//
//  ProfileSettingViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit

class ProfileSettingViewController: UIViewController {

    
    lazy var profileButton = {
        let button = CustomProfileButton()
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    let profileCameraLogo = {
        let logo = UIImageView()
        logo.image = UIImage(systemName: "camera.fill")
        logo.backgroundColor = UIColor.mainColor
        logo.tintColor = .white
        logo.contentMode = .center
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
        warning.text = "닉네임에 @는 포함될 수 없어요."
        
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
        navigationItem.title = "Profile Setting"
        configureHierarchy()
        configureLayout()
        completeButton.isEnabled = false
        
    }
    override func viewDidLayoutSubviews() {
        profileButton.layer.cornerRadius = profileButton.frame.width / 2
        profileCameraLogo.layer.cornerRadius = profileCameraLogo.frame.width/2
        nicknameTextfield.layer.addBorder([.bottom], color: .lightGray, width: 1)
    }
    
    @objc func profileButtonTapped() {
        let vc = SelectProfileViewController()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nicknameDidChange() {

        guard let text = nicknameTextfield.text else {
            return
        }
        if text.count >= 2 && text.count < 8 {
            warningTextfield.text = "사용할 수 있는 닉네임이에요."
            if text.contains("@") || text.contains("#") || text.contains("$") || text.contains("%") {
                warningTextfield.text = "닉네임에 @, #, $, % 는 포함할 수 없어요."
                completeButton.isEnabled = false
            }
            if text.contains(" ") {
                warningTextfield.text = "공백은 불가능해요."
                completeButton.isEnabled = false
            }
            if Int(text) != nil  {
                warningTextfield.text = "닉네임에 숫자는 포함할 수 없어요"
                completeButton.isEnabled = false
            }
        } else {
            warningTextfield.text = "2글자 이상 10글자 미만으로 설정해주세요"
            completeButton.isEnabled = false
        }
        
        
        if warningTextfield.text != "사용할 수 있는 닉네임이에요." {
            completeButton.isEnabled = false
        } else {
            completeButton.isEnabled = true
        }
                
        
    }
    
    @objc func completeButtonTapped() {
        Variable.user = nicknameTextfield.text ?? "위에서 통과하고 온 닉네임이라 nil의 경우는 없음. 고로 이 문장도 나올 일이 없음."
       
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        
        let vc = UINavigationController(rootViewController: MainViewController())
        
        vc.navigationBar.tintColor = .black
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
        
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
