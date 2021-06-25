//
//  MarkerInfoWindow.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 6/24/21.
//

import UIKit

class MarkerInfoWindow: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var skyImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var coutryLabel: UILabel!
    

    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed(String(describing:MarkerInfoWindow.self), owner: self, options:nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        container.layer.cornerRadius = 5
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemBlue.cgColor
    }

}
