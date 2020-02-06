//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by FGT MAC on 2/6/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {

    //this instance of GigController will be use for dependency injection to the rest of the views
    let gigController = GigController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (gigController.bearer == nil){
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        // TODO: fetch gigs here
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        return cell
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            if let logInVC = segue.destination as? LoginViewController {
                logInVC.gigController = gigController
            }
        }
    }
 

}
