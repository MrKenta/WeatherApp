//
//  ViewController.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/7/21.
//

import UIKit
import EDColor

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.backgroundColor = UIColor.init(crayola:"Green")
        startButton.setTitleColor(UIColor.black, for: .normal)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func startAction(_ sender: Any) {
        let tabBar = UITabBarController()
        var controllers = [UIViewController]()
        let historyVC = HistoryVC()
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let mapVC = storyboard.instantiateViewController(identifier:"mapVC") as? MapVC
        else { return }
        mapVC.tabBarItem = UITabBarItem(title:"Map", image:UIImage(systemName:"safari.fill"), tag:0)
        historyVC.tabBarItem = UITabBarItem(title:"History", image:UIImage(systemName:"h.square.fill"), tag: 1)
        controllers.append(mapVC)
        controllers.append(historyVC)
        tabBar.viewControllers = controllers
        navigationController?.pushViewController(tabBar, animated: true)
        
        
    }
    
}

