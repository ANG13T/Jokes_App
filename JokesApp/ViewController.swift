//
//  ViewController.swift
//  JokesApp
//
//  Created by Angelina Tsuboi on 11/16/20.
//

import UIKit

class ViewController: UITableViewController {
    var jokes = [Joke]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Joke", for: indexPath)
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Description"
        return cell
    }

}

