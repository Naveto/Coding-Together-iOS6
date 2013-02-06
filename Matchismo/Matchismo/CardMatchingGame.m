//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Javier Barredo on 31/01/13.
//  Copyright (c) 2013 CSA Sistemas. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) BOOL isOtherCard;//Task 4
@property (strong, nonatomic)NSMutableArray * otherCards;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards{
    if (!_cards) _cards=[[NSMutableArray alloc]init];
    return _cards;
}
-(NSMutableArray *) otherCards{
    if (!_otherCards) self.otherCards=[[NSMutableArray alloc]init];
    return _otherCards;
}
-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self =[super init];
    
    if (self) {
        for (int i=0; i< count; i++) {
            Card *card =[deck drawRandomCard];
            if (!card) {
                self = nil;
            }else{
                self.cards[i] =card;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(void)flipCardAtIndex:(NSUInteger)index{
    
    Card * card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if(!card.faceUp){
            // see if flipping this card up creates a match
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.lastResult= [NSString stringWithFormat:@"Matched %@ & %@ for %d points",card.contents, otherCard.contents,matchScore * MATCH_BONUS]; //Task 3
                        
                    }else{
                        
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastResult= [NSString stringWithFormat:@"%@ and %@ don’t match! %d point penalty!",card.contents, otherCard.contents,MISMATCH_PENALTY]; //Task 3
                    }
                }
            }
            
            self.score -= FLIP_COST;
            if (!self.lastResult) self.lastResult =[NSString stringWithFormat:@"Flipped up %@",card.contents]; //Task 3
            
           
        }
        card.faceUp = !card.isFaceUp;
        
    }
}

-(void)flipCard3AtIndex:(NSUInteger)index{ //Task 4 all 
    
    Card * card = [self cardAtIndex:index];
    _isOtherCard = NO;
    
    if (!card.isUnplayable) {
        if(!card.faceUp){
            // see if flipping this card up creates a match
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    if (!_isOtherCard) {
                        [self.otherCards addObject:otherCard];
                        _isOtherCard =YES;
                    } else {
                        [self.otherCards addObject:otherCard];
                        NSLog(@"2 otherCards %@",_otherCards);
                        int matchScore = [card match:self.otherCards];
                        if (matchScore) {
                            otherCard.unplayable = YES;
                            card.unplayable = YES;
                            Card *tempCard;
                            tempCard=self.otherCards[0];
                            tempCard.unplayable=YES;
                            self.score += matchScore * MATCH_BONUS;
                            self.lastResult= [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points",card.contents, otherCard.contents,tempCard.contents,matchScore *MATCH_BONUS];
                            }
                        
                            else{
                            
                            otherCard.faceUp = NO;
                            Card *tempCard;
                            tempCard=self.otherCards[0];
                            tempCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.lastResult= [NSString stringWithFormat:@"%@ %@ %@ don’t match! %d point penalty!",card.contents, otherCard.contents,tempCard.contents,MISMATCH_PENALTY]; 
                            }
                        }
                    }
                }
        
            
            self.score -= FLIP_COST;
            if (!self.lastResult) self.lastResult =[NSString stringWithFormat:@"Flipped up %@",card.contents]; //Task 3
            
            
            
        }
        card.faceUp = !card.isFaceUp;
        self.otherCards = nil;
        }
    }
    


-(void)gameDeal{
    self.score=0;
    
}
@end
