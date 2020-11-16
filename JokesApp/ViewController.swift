//
//  ViewController.swift
//  JokesApp
//
//  Created by Angelina Tsuboi on 11/16/20.
//

import UIKit

class ViewController: UITableViewController {
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var urlString = "";
        print(urlString)
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://opentdb.com/api.php?amount=10"
        }else if navigationController?.tabBarItem.tag == 1{
            urlString = "https://opentdb.com/api.php?amount=10&category=15"
        }else{
            urlString = "https://opentdb.com/api.php?amount=10&category=20"
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }else{
                showError()
            }
        }else{
            showError()
        }
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the questions", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        print("parsing JSON")
   
        if let jsonQuestions = try? decoder.decode(Questions.self, from: json){
            questions = jsonQuestions.results
            print(questions.count)
            tableView.reloadData()
        }else{
            print("soemthing failed")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = questions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Joke", for: indexPath)
        cell.textLabel?.text = question.question
        cell.detailTextLabel?.text = question.correct_answer
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = questions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

