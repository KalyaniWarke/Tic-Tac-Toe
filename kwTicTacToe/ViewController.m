//
//  ViewController.m
//  kwTicTacToe
//
//  Created by Kalyani on 21/09/16.
//  Copyright © 2016 kalyani Warke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initGame
{
    numbetOfTurns = 0;
    currentPlayer = 1;
    isGameFinished = false;
    
    winningCombination =@[@[@0,@1,@2],@[@3,@4,@5],@[@6,@7,@8],@[@0,@3,@6],@[@1,@4,@7],@[@2,@5,@8],@[@0,@4,@8],@[@2,@4,@6]];
    
    currentState =[[NSMutableArray alloc]initWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil];
    
    for(int index=100;index<108;index++){
        
        UIButton *mybutton=[self.view viewWithTag:index];
        [mybutton setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
        
    }
}

-(void)win:(NSString *)player
{
    [self showAlertWithTitle:@"ok" Message:[NSString stringWithFormat:@"congrats!,%@ won the game",player]];
}
-(void)showAlertWithTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ok Butoon Pressed !");
        
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)alertForEndWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [self initGame];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction: ok];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        exit(0);
    }];
    [alert addAction: cancel];

    [self presentViewController:alert animated:YES completion:nil ];
}

- (IBAction)buttonAction:(id)sender {
    
    numbetOfTurns = numbetOfTurns+1;
    UIButton *title = sender;
    UIImage *playerImage;
    int player = currentPlayer;
    
    BOOL isButtonNotSelected = [[currentState objectAtIndex:(title.tag-100)]isEqual:@0 ];
    
    if (isButtonNotSelected) {
        if (!isGameFinished) {
            if (player==1) {
                playerImage = [UIImage imageNamed:@"nought"];
                [currentState replaceObjectAtIndex:(title. tag-100) withObject:@1];
                
                currentPlayer = 2;
            }
            else{
                playerImage =[UIImage imageNamed:@"cross"];
                
                [currentState replaceObjectAtIndex:(title. tag-100) withObject:@2];
                currentPlayer = 1;

            }
        }
        [title setBackgroundImage:playerImage forState:UIControlStateNormal];
    }
    else{
        [self showAlertWithTitle:@"Caution" Message:@"please select another file"];
    }
    if(numbetOfTurns>=5)
    {
        for (NSArray *combination in winningCombination)
        {
            int indexOfButtonOne=[[combination objectAtIndex:0]intValue];
            
            int indexOfButtonTwo=[[combination objectAtIndex:1]intValue];
            
            int indexOfButtonThree =[[combination objectAtIndex:2]intValue];
            
            NSNumber *stateAtButtonOne = [currentState objectAtIndex:indexOfButtonOne];
            NSNumber *stateAtButtontwo = [currentState objectAtIndex:indexOfButtonTwo];
            NSNumber *stateAtButtonthree = [currentState objectAtIndex:indexOfButtonThree];
            
            
            if (![stateAtButtonOne isEqual:@0] && [stateAtButtonOne isEqual:stateAtButtontwo] && [stateAtButtontwo isEqual:stateAtButtonthree])
            {
                isGameFinished =YES;
                NSString *winnerString = [NSString stringWithFormat:@"player %d has won",player];
                [self alertForEndWithTitle:winnerString message:@"Do you want to play again"];
                break;
                
            }


        }
    
       
    }
    if (!isGameFinished)
    {
        BOOL zeroValuePresent = [currentState containsObject:@0];
        
        if (!zeroValuePresent)
        {
            [self  alertForEndWithTitle:@"Game Draw" message:@"Do you want to play again"];
        }
    }
}
@end
