//
//  PlayingCard.h
//  Matchismo
//
//  Created by Javier Barredo on 30/01/13.
//  Copyright (c) 2013 CSA Sistemas. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
