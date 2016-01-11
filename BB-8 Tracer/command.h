//
//  command.h
//  BB-8 Tracer
//
//  Created by Alexandre Richet on 10/01/16.
//  Copyright © 2016 Alexandre Richet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RobotKit/RobotKit.h>
#import <RobotUIKit/RobotUIKit.h>

@interface command : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (retain) UIPickerView *pickerview;
@property (retain) NSMutableArray *dataList;

- (void) arrowUpFunc;
- (void) arrowRightFunc;
- (void) arrowBottomFunc;
- (void) arrowLeftFunc;
- (void) startBFunc;
- (void) moveToHeading:(float)heading velocity:(float)velocity;
- (void) stop:(NSTimer *)timer;

@end
