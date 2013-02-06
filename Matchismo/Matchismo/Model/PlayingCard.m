//
//  PlayingCard.m
//  Matchismo
//
//  Created by Javier Barredo on 30/01/13.
//  Copyright (c) 2013 CSA Sistemas. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards{
    
    int score= 0;
    
    if (otherCards.count ==1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 2;
        } else if (otherCard.rank == self.rank){
            score = 4;
        }
    }else if (otherCards.count==2){ //Task 4
        PlayingCard *otherCard = otherCards[0];
        PlayingCard *otherOtherCard =otherCards[1];
        if (otherCard.rank==self.rank && otherCard.rank==otherOtherCard.rank){
            score=16;
        }else if ([otherCard.suit isEqualToString:self.suit] && [otherCard.suit isEqualToString:otherOtherCard.suit]){
            score=8;
        }
        
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if ([otherOtherCard.suit isEqualToString:self.suit]){
            score = 1;
        } else if ([otherCard.suit isEqualToString:otherOtherCard.suit]){
            score = 1;
        } else if (otherCard.rank==self.rank){
            score = 6;
        } else if (otherCard.rank==otherOtherCard.rank){
            score = 6;
        } else if (otherOtherCard.rank==self.rank){
            score = 6;
        }
        
    }
    NSLog(@"score: %d",score);
    return score;
}


-(NSString *)contents{
    
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings [self.rank] stringByAppendingString:self.suit];
    
}
@synthesize suit = _suit;

+(NSArray *)validSuits{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit{
    
   
    if ([[PlayingCard validSuits] containsObject:suit] ) {
        _suit=suit;
    }
    
}

-(NSString *) suit{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings{
    
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank{
    
    return [self rankStrings].count-1;
}
-(void)setRank:(NSUInteger)rank{
    
    if (rank <= [PlayingCard maxRank]) {
        _rank=rank;
    }
}
@end
