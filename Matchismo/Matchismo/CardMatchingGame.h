//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Javier Barredo on 31/01/13.
//  Copyright (c) 2013 CSA Sistemas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(void)flipCard3AtIndex:(NSUInteger)index; //Task 4

-(Card *)cardAtIndex:(NSUInteger)index;

-(void)gameDeal;

@property (nonatomic, readonly)int score;
@property (nonatomic) NSString *lastResult; //Task 3

@end
