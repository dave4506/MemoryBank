//
//  SettingsViewController.swift
//  memorybank
//
//  Created by David Sun on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyStyles()
        // Do any additional setup after loading the view.
    }
    

    func applyStyles() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.automatic
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
