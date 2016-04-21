//
//  ViewController.swift
//  Xs and Os
//
//  Created by Cole Britton on 1/22/16.
//  Copyright © 2016 Cole Britton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var crossesTurn = true;
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0,];
    
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]];
    
    var gameActive = true;
    
    @IBOutlet var playAgainButton: UIButton!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var cellButton: UIButton!
    @IBAction func playAgainPressed(sender: AnyObject) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0,];
        gameActive = true;
        winnerLabel.hidden = true;
        winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y);
        playAgainButton.hidden = true;
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y);
        
        var buttonToClear : UIButton;
        for var i = 0; i < 9; i++ {
            buttonToClear = view.viewWithTag(i) as! UIButton;
            buttonToClear.setImage(nil, forState: UIControlState.Normal);
        }
    }
    @IBAction func cellButtonPressed(sender: AnyObject) {
        
        let tag = sender.tag;
        if gameActive {
            if gameState[tag] == 0 {
                if crossesTurn {
                    sender.setImage(UIImage(named: "cross.png"), forState: UIControlState.Normal);
                    gameState[tag] = 2;
                } else {
                    sender.setImage(UIImage(named: "nought.png"), forState: UIControlState.Normal);
                    gameState[tag] = 1;
                }
                crossesTurn = !crossesTurn;
                
                for combo in winningCombinations {
                    if gameState[combo[0]] != 0 && gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]] {
                        
                        if gameState[combo[0]] == 1 {
                            winnerLabel.text = "Noughts win!";
                        } else {
                            winnerLabel.text = "Crosses win!";
                        }
                        
                        gameOver();
                        gameActive = false;
                    }
                }
                if gameActive {
                    gameActive = false;
                    
                    for buttonState in gameState {
                        if buttonState == 0 {
                            gameActive = true;
                        }
                    }
                    
                    if !gameActive {
                        winnerLabel.text = "It's a Draw!";
                        gameOver();
                    }
                }
            }
        }
    }
    
    func gameOver() {
        
        UIView.animateWithDuration(1) { () -> Void in
            self.winnerLabel.hidden = false;
            self.winnerLabel.center = CGPointMake(self.winnerLabel.center.x + 400, self.winnerLabel.center.y);
            self.playAgainButton.hidden = false;
            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y);
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.hidden = true;
        winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y);
        playAgainButton.hidden = true;
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y);
    }
    
    override func viewDidLayoutSubviews() {
        //winnerLabel.alpha = 0;
        //winnerLabel.center = CGPointMake(winnerLabel.center.x - 400, winnerLabel.center.y);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

