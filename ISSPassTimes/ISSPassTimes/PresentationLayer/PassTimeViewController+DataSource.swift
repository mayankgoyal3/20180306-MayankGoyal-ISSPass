//
//  PassTimeViewController+DataSource.swift
//  ISSPassTimes
//
//  Created by Mayank Goyal on 06/03/18.
//  Copyright © 2018 Mayank Goyal. All rights reserved.
//

import UIKit

extension PassTimeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- table view delegate and datasource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passTimeData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if passTimeData.count > 0 {
            return 0.0
        }
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Show the placeholder text if data is not available
        if passTimeData.count > 0 {
            return ""
        }
        
        return "No International Space Station Pass Times".localize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passTimeCell", for: indexPath)

        if let dictDisplay = self.passTimeData[indexPath.row] as? [String: Any] {
            if let duration = dictDisplay["duration"] as? Double {
                cell.textLabel?.text = "Duration: " + String(duration)
            }
            
            if let risetime = dictDisplay["risetime"] as? Double {
                cell.detailTextLabel?.text = "Time: " + self.getTheDateFromTime(timestamp: risetime)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // Change the timestamp in date format
    func getTheDateFromTime(timestamp: Double) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd MMM, yyyy hh:mm aa"
        let value = timestamp / 1000
        let date = NSDate(timeIntervalSince1970: TimeInterval(value))
        return dateformat.string(from: date as Date)
    }
}
