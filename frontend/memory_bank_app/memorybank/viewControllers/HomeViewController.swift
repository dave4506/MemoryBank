//
//  HomeViewController.swift
//  memorybank
//
//  Created by David Sun on 11/24/19.
//  Copyright © 2019 Dubal, Rohan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickSettings(_ sender: Any) {
        let rootVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "entrypoint")
        self.navigationController?.pushViewController(rootVC, animated: true)
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
