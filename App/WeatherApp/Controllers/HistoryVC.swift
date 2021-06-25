//
//  HistoryVC.swift
//  WeatherApp
//
//  Created by Raman Krutsiou on 5/12/21.
//

import UIKit

class HistoryVC: UITableViewController {
    
    var dataArray = DataManager.shared.readObjects()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = UINib(nibName:String(describing:WeatherCell.self), bundle: nil)
        tableView.register(cell, forCellReuseIdentifier:String(describing:WeatherCell.self))
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        dataArray = DataManager.shared.readObjects()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:String(describing:WeatherCell.self), for: indexPath)

        guard let weatherCell = cell as? WeatherCell else { return cell }
        weatherCell.setCell(sample:dataArray[indexPath.row])

        
        return weatherCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let detailVC = storyboard.instantiateViewController(identifier:String(describing:DetailVC.self)) as? DetailVC else { return }
        navigationController?.pushViewController(detailVC, animated: true)
        detailVC.sample = dataArray[indexPath.row]
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            DataManager.shared.removeObject(item:self.dataArray[indexPath.row])
                self.dataArray.remove(at:indexPath.row)
                tableView.reloadData()
                complete(true)
            }
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
            
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

