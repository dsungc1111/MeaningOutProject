//
//  ViewController.swift
//  MeaningOut
//
//  Created by 최대성 on 6/13/24.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {

    let projectTitle = {
        let title = UILabel()
        title.text = "Meaning Out"
        title.font = UIFont(name: "Marker Felt Wide", size: 50)
        title.textAlignment = .center
        title.textColor = UIColor.mainColor
        return title
    }()
    let launchImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.launch
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var startButton = {
        let button = BigSizeButton()
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
    }
    
    @objc func startButtonTapped() {
        let vc = ProfileViewController()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        vc.navigationItem.title = "PROFILE SETTING"
        navigationController?.pushViewController(vc, animated: true)
        Variable.profileImage = ""
        Variable.user = ""
    }
    
    func configureHierarchy() {
        view.addSubview(launchImageView)
        view.addSubview(projectTitle)
        view.addSubview(startButton)
    }
    func configureLayout() {
        launchImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(220)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(185)
            
        }
        projectTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(105)
            make.bottom.equalTo(launchImageView.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.height.equalTo(50)
        }
    }

    
    

}

