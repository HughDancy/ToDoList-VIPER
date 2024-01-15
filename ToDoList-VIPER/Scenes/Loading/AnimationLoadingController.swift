//
//  AnimationLoadingController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 12.01.2024.
//

import UIKit
import SnapKit

final class AnimationLoadingController: UIViewController {
    
    //MARK: - Outlets
    private lazy var loadingBackground: UIImageView = {
        let imageView = UIImageView()
        let picture = UIImage(named: "loadingBackground")
        imageView.image = picture
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var loadingImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 240, height: 128))
        let picture = UIImage(named: "loadingAnimate")
        imageView.image = picture
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()
    
    //MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
        loadingImage.center = view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarcy()
        setupLayout()
    }
    
    deinit {
        print("AnimationLoadingControoler is ☠️")
    }
    
    //MARK: - Setup Outlets
    private func setupHierarcy() {
        view.addSubview(loadingBackground)
        view.sendSubviewToBack(loadingBackground)
        view.addSubview(loadingImage)
        view.addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        loadingBackground.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.leading.trailing.equalTo(view)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }

    }
    
    //MARK: - Animate Method
    private func animate() {
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.loadingImage.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
            
        }
        
        UIView.animate(withDuration: 1.5, animations: {
            self.loadingImage.alpha = 0
            self.activityIndicator.stopAnimating()
        }) { done  in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    let mainModule = HomeTabBarRouter.createHomeTabBar()
                    
                    mainModule.modalTransitionStyle = .crossDissolve
                    mainModule.modalPresentationStyle = .fullScreen
                    self.present(mainModule, animated: true)
//                    self.navigationController?.pushViewController(mainModule, animated: true)
                })
            }
        }
    }
    
    //MARK: - Next Path Method
    
}
