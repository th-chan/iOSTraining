//
//  EntryViewController.swift
//  SearchBookApp
//
//  Created by Chan, Tsz Hin on 12/4/2018.
//  Copyright © 2018 temp. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    
    @IBOutlet weak var btnClick: CustomButton!
    
    @IBOutlet weak var lblWelcomeMessage: UILabel!
    
    @IBOutlet weak var tfInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Entry View"
        //self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
//        lblWelcomeMessage.text = NSLocalizedString("welcome_message", comment: "")
//        lblWelcomeMessage.text = Bundle.main.localizedString(forKey: "welcome_message", value: nil, table: nil)
        
        btnClick.addTarget(self, action: #selector(touchDown), for: .touchDown)
    }
    
    @objc func touchDown() {
        print("touch down")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // save the user name, like cookies
        if let userName = UserDefaults.standard.string(forKey: "USER_NAME") {
            self.setWelcomeMessage(userName: userName)
        } else {
            showWelcomeDialog()
        }
    }
    
    func showWelcomeDialog() {
        let alertViewController = UIAlertController(title: "Welcome", message: "Please enter your name", preferredStyle: .alert)
        alertViewController.addTextField { (tf) in tf.placeholder = "Please enter your name"}
        let lblWelcomeMessage = self.lblWelcomeMessage
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            if let textField = alertViewController.textFields?.first, let userName = textField.text {
                print(userName)
                UserDefaults.standard.set(userName, forKey: "USER_NAME")
                UserDefaults.standard.synchronize()
                lblWelcomeMessage?.text = String.init(format: self.getString("welcome_message"), userName)
            }
        }
        alertViewController.addAction(confirmAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func setWelcomeMessage(userName: String) {
        lblWelcomeMessage?.text = String.init(format: self.getString("welcome_message"), userName)
    }
    
    @IBAction func btnClick(_ sender: Any) {
        print("Clicked")
        let searchWord = tfInput.text
        
        let booklistVC = BookListTableViewController(keyword: searchWord!)
//        self.present(booklistVC, animated: true) {
//
//        }
        self.navigationController?.pushViewController(booklistVC, animated: true)
//        let detailVC = DetialViewController()
////        self.present(detailVC, animated: true)
//        let navVC = UINavigationController(rootViewController: detailVC)
//        self.present(navVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

}
