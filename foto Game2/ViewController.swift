//
//  ViewController.swift
//  foto Game2
//
//  Created by admin on 24.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var state = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winState = [[0, 8], [1,9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14], [7, 15]]
    
    var isFreezPlayer = false
    
    var images = ["1", "2", "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func game(_ sender: UIButton) {
        
        if state[sender.tag - 1] != 0 {
            return
        }
                state[sender.tag - 1] = 1
                sender.setBackgroundImage(UIImage(named: images[sender.tag - 1 ]), for: .normal)
                var count = 0
                for item in state {
                    if item == 1 {
                        count += 1
                    }
                }
                if count == 2 {
                    isFreezPlayer = true
                    for winArray in winState {
                        if  state[winArray[0]] == state[winArray[1]] &&
                                state[winArray[0]] == 1 {
                            state[winArray[0]] = 2
                            state[winArray[1]] = 2
                            isFreezPlayer = false
                        }
                    }
                    if isFreezPlayer {
                        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
                    }
                }
                var countWiner = 0
                for item in state {
                    if item == 2 {
                        countWiner += 1
                    }
                    }
              
                    if countWiner == 16 {
                        let alert = UIAlertController(title: "Pozdrav", message: "you win", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { UIAlertAction in self.clearGame()
                            
                        }))
                    
                    present (alert, animated: true)
                }
                
                
            }
            @objc func clear() {
                isFreezPlayer = false
                for i in 0...15 {
                    if state[i] == 1 {
                        state[i] = 0
                        let button = view?.viewWithTag(i + 1) as! UIButton
                        button.setBackgroundImage(nil, for: .normal)
                    }
                }
                }
                func clearGame() {
                    isFreezPlayer = false
                    for i in 0...15 {
                    state [i] = 0
                    let button  = view.viewWithTag(i + 1) as! UIButton
                            button.setBackgroundImage(nil, for: .normal)

                }
                //shufle
                images.shuffle()
                winState.removeAll ()
                
                for i in 0...15 {
                    for j in 0...15 {
                        if images[i] == images [j] && i != j {
                            winState.append([i, j])
                            break
                        }
                    }
                }
            }
        }

