//
//  ViewController.swift
//  JokesApp
//
//  Created by Angelina Tsuboi on 11/16/20.
//

import UIKit

class ViewController: UITableViewController {
    var questions = [Question]()
    var urlString = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Questions"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showSource))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON(){
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://opentdb.com/api.php?amount=10"
        }else{
            urlString = "https://opentdb.com/api.php?amount=10&category=20"
        }
        
        performSelector(inBackground: #selector(showData), with: nil)
    }
    
    @objc func showData(){
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
            parse(json: data)
            return
        }
      }
      performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showError(){
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
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        }else{
            tableView.performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
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
    
    @objc func showSource(){
        let ac = UIAlertController(title: "Open Trivia Database", message: "https://opentdb.com", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showSearch(){
        let ac = UIAlertController(title: "Search for Question: ", message: nil, preferredStyle: .alert)
                ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
        let submitAction = UIAlertAction(title: "Search", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.search(index: answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func search(index: String){
        let lowerSearch = index.lowercased()
        
        if(index.isEmpty || index == ""){
            showData()
            return
        }
        var newQuestions: [Question] = []
        for question in questions{
            if(question.question.lowercased().contains(lowerSearch)){
                newQuestions.append(question)
            }
        }
        questions = newQuestions
        tableView.reloadData()
    }

}

