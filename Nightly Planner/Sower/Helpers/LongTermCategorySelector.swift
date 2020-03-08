//
//  LongTermCategorySelector.swift
//  Nightly Planner
//
//  Created by Drew Foster on 12/10/18.
//  Copyright © 2018 Drew Foster. All rights reserved.
//

import UIKit

class LongTermCategorySelector: UITableViewController {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellId)
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "Long Term Goal 1"
            break
        default:
            cell.textLabel?.text = "Long Term Goal 2"
            break
        }
        cell.textLabel?.textColor = .blue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
