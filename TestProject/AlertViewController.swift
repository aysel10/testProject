//
//  AlertViewController.swift
//  TestProject
//
//  Created by Ayselkas on 5/19/18.
//  Copyright © 2018 IceL. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBAction func exit(_ sender: Any) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = defaults.string(forKey: "name")
        maxTemp.text = defaults.string(forKey: "tempMax")
        minTemp.text = defaults.string(forKey: "tempMin")
        temp.text = defaults.string(forKey: "temp")
        
        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
