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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        view.addSubview(launchImageView)
        view.addSubview(projectTitle)
    }
    func configureLayout() {
        launchImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(220)
            
        }
        projectTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.bottom.equalTo(launchImageView.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    
    

}

