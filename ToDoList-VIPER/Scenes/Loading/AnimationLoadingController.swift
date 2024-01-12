//
//  AnimationLoadingController.swift
//  ToDoList-VIPER
//
//  Created by Борис Киселев on 12.01.2024.
//

import UIKit
import SnapKit

class AnimationLoadingController: UIImagePickerController {
    
    //MARK: - Outlets
    private lazy var loadingBackground: UIImageView = {
        let imageView = UIImageView()
        let picture = UIImage(named: "loadingBackground")
        imageView.image = picture
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var loadingImage: UIImageView = {
        let imageView = UIImageView()
        let picture = UIImage(named: "loadingAnimate")
        imageView.image = picture
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(loadingBackground)
        view.addSubview(loadingImage)
        
        
    }
    
    
    
    
}
