//
//  Suggestion.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 6/23/21.
//

import UIKit

class Suggestion: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
        setLabel()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
        setLabel()
    }

    func commonInit () {
        Bundle.main.loadNibNamed(String(describing:Suggestion.self), owner: self, options:nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func hideView(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func setLabel() {
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name:"System", size: 15)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byTruncatingTail
    }
}
