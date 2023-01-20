//
//  ViewController.swift
//  Hangman
//
//  Created by Amr El-Fiqi on 17/01/2023.
//

import UIKit

class ViewController: UIViewController {
    var word = ""
    var wordArray = [String]()
    var correctAnswer = ""
    var correctAnswerArray = [String]()
    var usedLetter = [String]()
    var wrongAnswers = 0
    var words = [String]()
    var score = 0
    var totalScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let wordFileURL = Bundle.main.url(forResource: "hangman", withExtension: ".txt"){
            if let wordContent = try? String(contentsOf: wordFileURL){
                words = wordContent.components(separatedBy: "\n")
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(UsersInput))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Start Over", style: .plain, target: self, action: #selector(startOver))
        loadGame()
    }
    
    func loadGame (){
        let choosenWord = words.randomElement()
        correctAnswer = choosenWord!
        for item in choosenWord! {
            correctAnswerArray.append(String(item))
            wordArray.append("?")
            word += "?"
        }
        print(correctAnswerArray)
        print(correctAnswer)
        title = "\(word) | Score: \(score)"
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
        var lowAnswer = answer.lowercased()
        usedLetter.append(lowAnswer)
        if answer.count > 1 || answer.count <= 0{
            let ac = UIAlertController(title: "Wrong Input", message: "Please enter only 1 character", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
        else {
            if correctAnswerArray.contains(answer){
                for (index,item) in correctAnswer.enumerated() {
                    if (Character(answer) == item){
                        wordArray[index] = lowAnswer
                        score += 1
                        totalScore += 1
                        print(wordArray)
                    }
                }
                word = wordArray.joined()
                print(word)
            }
            else{
                score -= 1
                totalScore -= 1
                wrongAnswers += 1
            }
            
            title = "\(word) | Score: \(score)"
        }
        checkdeath()
        checkWin()
    }
    func checkWin(){
        if (word == correctAnswer){
            let ac = UIAlertController(title: "Good Job!", message: "You guessed the word correctly!\nTotal Score: \(totalScore)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Awesome!", style: .default ))
            present(ac, animated: true)
            startOver()
           
        }
    }
    
    func checkdeath(){
        if (wrongAnswers == correctAnswer.count){
            let ac = UIAlertController(title: "You Died", message: "You have used all your chances!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try Again", style: .default ))
            present(ac, animated: true)
            startOver()
        }
    }
    
    @objc func startOver(){
        wrongAnswers = 0
        score = 0
        word.removeAll()
        wordArray.removeAll()
        correctAnswerArray.removeAll()
        loadGame()
    }
}
