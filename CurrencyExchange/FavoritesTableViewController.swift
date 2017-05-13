//
//  FavoritesTableViewController.swift
//  CurrencyExchange
//
//  Created by Yui Tamaki on 5/8/17.
//  Copyright © 2017 Yui Tamaki. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    var currencies = ["US Dollar", "Japanese Yen", "British Pound", "Canadian Dollar", "Chinese Yuan", "European Union Euro"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsMultipleSelection = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellLabel", for: indexPath)

        cell.textLabel?.text = currencies[indexPath.row]
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
