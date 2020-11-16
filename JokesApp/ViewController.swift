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
        let urlString = "https://sv443.net/jokeapi/v2/joke/Dark?amount=5"
        print(urlString)
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        print("parsing JSON")
        print(json.isEmpty)
        if let jsonJokes = try? decoder.decode(Jokes.self, from: json){
            jokes = jsonJokes.jokes
            print(jokes)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let joke = jokes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Joke", for: indexPath)
        cell.textLabel?.text = joke.setup
        cell.detailTextLabel?.text = joke.delivery
        return cell
    }

}

