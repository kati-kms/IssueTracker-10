//
//  ProfileViewController.swift
//  IssueTracker
//
//  Created by 강민석 on 2020/11/02.
//

import UIKit

class ProfileViewController: UIViewController {
	
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
		super.viewDidLoad()
        setRound(with: logoutButton, offset: 10)
        setRound(imageView: avatarImageView)
		configureProfile(user: AppData.user)
	}
    
    @IBAction func logoutButtonTouched(_ sender: Any) {
        AppData.reset()
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        sceneDelegate.configureSignIn()
    }
	
	func setRound(imageView: UIImageView) {
		imageView.layer.cornerRadius = imageView.bounds.width / 2
		imageView.layer.masksToBounds = true
	}
    
    func setRound(with view: UIView, offset: CGFloat) {
        view.layer.cornerRadius = offset
        view.layer.masksToBounds = true
    }

	func configureProfile(user: User) {
		nameLabel.text = user.name
		avatarImageView.image = UIImage(named: "Icon")
		guard let url: URL = URL(string: user.avatorURL ?? "") else { return }
        ImageCache.shared.downloadImage(url: url) { (avatarImage: UIImage) in
			DispatchQueue.main.async {
				self.avatarImageView.image = avatarImage
			}
		}
	}
}
