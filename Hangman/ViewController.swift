//
//  ViewController.swift
//  Hangman
//
//  Created by Amr El-Fiqi on 17/01/2023.
//

import UIKit

class ViewController: UIViewController {
    var word = ""
    var usedLetter = [String]()
    var wrongAnswers = 0
    var words = [String]()
    var score = 0 {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let wordFileURL = Bundle.main.url(forResource: "hangman", withExtension: ".txt"){
            if let wordContent = try? String(contentsOf: wordFileURL){
                words = wordContent.components(separatedBy: "\n")
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UsersInput))
        
        loadGame()
    }
    
    func loadGame (){
        let choosenWord = words.randomElement()
        for item in choosenWord! {
            let strLetter = String(item)
            
            if usedLetter.contains(strLetter){
                word += strLetter
            }
            else{
                word += "?"
            }
        }
        title = "\(word) | Score:\(score)"
        usedLetter.removeAll()
    }
    
    @objc func UsersInput(){
        let ac = UIAlertController(title: "Enter a letter", message: "Enter a single character", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit (_ answer: String){
        if answer.count > 1 || answer.count <= 0{
            let ac = UIAlertController(title: "Wrong Input", message: "Please enter only 1 character", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        else {
            for item in word {
                let tempWord = Character(answer)
                if tempWord == item {
                    
                }
            }
        }
    }
}
