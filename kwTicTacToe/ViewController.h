//
//  ViewController.h
//  kwTicTacToe
//
//  Created by Kalyani on 21/09/16.
//  Copyright © 2016 kalyani Warke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int numbetOfTurns,currentPlayer;
    BOOL isGameFinished;
    
    NSArray *winningCombination;
    NSMutableArray *currentState;
}
- (IBAction)buttonAction:(id)sender;


@end

