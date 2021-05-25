//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/12/21.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var skyImage: UIImageView!
    @IBOutlet weak var weatherData: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(sample:InfoForUser) {
        
        let setImge = Downloader()
        setImge.downloader(country:sample.country) { (data) in
            DispatchQueue.main.async {
                self.countryImage.image = UIImage(data: data)
            }
        }
        placeLabel.text = "\(sample.country),\(sample.place)"
        weatherData.text = "\(sample.temperature),\(sample.sky)"
        switch sample.sky {
        case "Clear":
            skyImage.image = UIImage(named:"sun")
        case "Rain":
            skyImage.image = UIImage(named:"rain")
        case "Snow":
            skyImage.image = UIImage(named:"snow")
        case "Clouds":
            skyImage.image = UIImage(named:"strongcloiuds")
        case "few clouds":
            skyImage.image = UIImage(named:"suncloud")
        case "broken clouds":
            skyImage.image = UIImage(named:"suncloud")
        default:
            break
        }
}
}
