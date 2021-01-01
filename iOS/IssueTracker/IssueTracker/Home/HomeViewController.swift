//
//  HomeViewController.swift
//  IssueTracker
//
//  Created by 채훈기 on 2020/10/29.
//

import UIKit

class HomeViewController: UIViewController {
	
	let contents: [Content] = [
		Content(title: "Issue", imageName: "info.circle"),
		Content(title: "Label", imageName: "tag"),
		Content(title: "MileStone", imageName: "signpost.right")
	]
		
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	func presentViewController<T:UIViewController> (identifier: String, type: T) {
		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		if let viewController: T = mainStoryboard.instantiateViewController(withIdentifier: identifier) as? T {
			self.navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

extension HomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			presentViewController(identifier: "IssueViewController", type: IssueViewController())
		case 1:
			presentViewController(identifier: "LabelViewController", type: LabelViewController())
		case 2:
			presentViewController(identifier: "MileStoneViewController", type: MileStoneViewController())
		default:
			break
		}
	}
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = contents[indexPath.row].title
            content.image = UIImage(systemName: contents[indexPath.row].imageName)
            content.imageProperties.tintColor = .systemBlue
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = contents[indexPath.row].title
            cell.imageView?.image = UIImage(systemName: contents[indexPath.row].imageName)
        }
        return cell
    }
}

struct Content {
	let title: String
	let imageName: String
}
