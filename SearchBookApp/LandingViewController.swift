//
//  LandingViewController.swift
//  SearchBookApp
//
//  Created by Chan, Tsz Hin on 12/4/2018.
//  Copyright © 2018 temp. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var redButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Hello Landing")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeRed(_ sender: Any) {
        grayView.backgroundColor = UIColor.red
    }
    @IBAction func changeGreen(_ sender: Any) {
        grayView.backgroundColor = UIColor.green
    }
    @IBAction func changeBlue(_ sender: Any) {
        grayView.backgroundColor = .blue
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
