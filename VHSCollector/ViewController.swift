//
//  ViewController.swift
//  VHSCollector
//
//  Created by Stephen on 10/17/16.
//  Copyright © 2016 Stephen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var vhs : [VHS] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
        vhs = try context.fetch(VHS.fetchRequest())
            tableView.reloadData()
        }catch {
            
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vhs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let vhs = self.vhs[indexPath.row]
        cell.textLabel?.text = vhs.title
        cell.imageView?.image = UIImage(data: vhs.image as! Data)
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vhs = self.vhs[indexPath.row]
        performSegue(withIdentifier: "vhsSegue", sender: vhs)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! VHSViewController
        nextVC.vhs = sender as? VHS
        
    }
}

