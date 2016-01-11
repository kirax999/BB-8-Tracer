//
//  Cell.m
//  alfaSound5
//
//  Created by Richet Alexandre on 27/09/14.
//  Copyright (c) 2014 Richet Alexandre. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.direction = [array objectAtIndex:0];
        self.image = [array objectAtIndex:1];
        self.time = [array objectAtIndex:2];
    }
    return self;
}

- (NSString *) getDirection {
    return self.direction;
}

- (NSString *) getImage {
    return self.image;
}

- (NSString *) getTime {
    return self.time;
}

@end
