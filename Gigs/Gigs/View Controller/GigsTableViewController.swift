//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by FGT MAC on 2/6/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {

    private var gigsData: [Gig] = []{
        didSet{
            tableView.reloadData()
        }
    }
    //this instance of GigController will be use for dependency injection to the rest of the views
    let gigController = GigController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if (gigController.bearer == nil){
            performSegue(withIdentifier: "loginSegue", sender: self)
        }else{
            // TODO: fetch gigs here
            getData()
        }
        
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gigsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
        
        let singleGig = gigsData[indexPath.row]
        
        cell.textLabel?.text = singleGig.title
        cell.detailTextLabel?.text = singleGig.description
//        let df = DateFormatter()
//        df.timeStyle = .short
//        df.dateStyle = .none
        
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
    
    func getData() {
        gigController.getAllGigs { (results) in
  
            do{
                let gigs = try results.get()
                DispatchQueue.main.async {
                    self.gigsData = gigs
                }
                
            }catch{
                print("Error saving data to array: \(error)")
            }
        }
    }
    
    
}
