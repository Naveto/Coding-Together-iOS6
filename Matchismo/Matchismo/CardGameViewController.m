//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Javier Barredo on 29/01/13.
//  Copyright (c) 2013 CSA Sistemas. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (nonatomic) int gameType;
@end

@implementation CardGameViewController

-(CardMatchingGame*) game{
    if (!_game) _game=[[CardMatchingGame alloc]initWithCardCount:self.cardsButtons.count
                                               usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}



-(void)setCardsButtons:(NSArray *)cardsButtons{
    
    _cardsButtons=cardsButtons;
    [self updateUI];
}

-(void)updateUI{
    UIImage *cardBackimage =[UIImage imageNamed:@"card-back.png"];
    for (UIButton *cardButton in self.cardsButtons) {
        Card *card =[self.game cardAtIndex:[self.cardsButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled =!card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!cardButton.selected) {
            
            [cardButton setImage:cardBackimage forState:UIControlStateNormal];
        
        }else{
        
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.resultsLabel.text = self.game.lastResult; //Task 3
    self.game.lastResult=nil; //Task 3
    _gameTypeControl.enabled=NO; //task 4
    
}

-(void)setFlipCount:(int)flipCount{
    
    _flipCount =flipCount;
    self.flipsLable.text =[NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}
- (IBAction)flipCard:(UIButton *)sender {
    if (_gameType==1) {
        [self.game flipCard3AtIndex:[self.cardsButtons indexOfObject:sender]];
        self.flipCount++;
        [self updateUI];
    } else {
        [self.game flipCardAtIndex:[self.cardsButtons indexOfObject:sender]];
        self.flipCount++;
        [self updateUI];
    }
    
    
}

- (IBAction)dealButton:(UIButton *)sender {
    
    for (UIButton *cardButton in self.cardsButtons) {
        cardButton.selected = NO;
        cardButton.enabled =YES;
        cardButton.alpha = 1.0;
    }
    
    self.flipCount=0;
    _scoreLabel.text=@"Score: 0";
    _resultsLabel.text=nil;//@"";
    
    [_game gameDeal];
    _game = nil;
    _gameTypeControl.enabled=YES;//Task 4;
    
}

- (IBAction)gameTypeControl:(UISegmentedControl *)sender {
    
    UISegmentedControl *control = sender;
    _gameType= control.selectedSegmentIndex;
 
}
@end
