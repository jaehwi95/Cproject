//
//  SplashViewController.swift
//  Cproject
//
//  Created by Jaehwi Kim on 2024/07/31.
//

import Lottie
import UIKit

class SplashViewController: UIViewController {
//    @IBOutlet weak var appIconCenterYConstraint: NSLayoutConstraint!
//    @IBOutlet weak var appIconCenterXConstraint: NSLayoutConstraint!
//    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        appIconCenterXConstraint.constant = -(view.frame.width / 2) - (appIcon.frame.width / 2)
//        appIconCenterYConstraint.constant = -(view.frame.height / 2) - (appIcon.frame.height / 2)
//        
//        UIView.animate(withDuration: 2) { [weak self] in
//            self?.view.layoutIfNeeded()
//        }
//        
//        UIView.animate(withDuration: 3) { [weak self] in
//            let rotationAngle: CGFloat = CGFloat.pi
//            self?.appIcon.transform = CGAffineTransform(rotationAngle: rotationAngle)
//        }
        
        lottieAnimationView.play { _ in
            // Storyboard 가져오기
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            
            // Navigation 없이 window의 rootViewController를 바꿈 (메모리 절약)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first(where: { window in window.isKeyWindow }) {
                    window.rootViewController = viewController
                }
            }
        }
    }
}
