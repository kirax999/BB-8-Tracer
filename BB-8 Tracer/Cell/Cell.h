//
//  Cell.h
//  alfaSound5
//
//  Created by Richet Alexandre on 27/09/14.
//  Copyright (c) 2014 Richet Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : NSObject

@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *time;

- (id)initWithArray:(NSArray *)array;

- (NSString *) getDirection;
- (NSString *) getImage;
- (NSString *) getTime;

@end
