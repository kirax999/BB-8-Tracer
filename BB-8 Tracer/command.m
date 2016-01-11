//
//  command.m
//  BB-8 Tracer
//
//  Created by Alexandre Richet on 10/01/16.
//  Copyright © 2016 Alexandre Richet. All rights reserved.
//

#import "command.h"
#import "Cell.h"
#import "global.h"

extern RKConvenienceRobot *robot;

@interface command ()

@end

@implementation command

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BOT after: %@", robot);
    self.dataList = [[NSMutableArray alloc] init];

    UIButton *arrowUp = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowUp setImage:[UIImage imageNamed:@"arrowTop.png"] forState:UIControlStateNormal];
    [arrowUp setFrame:CGRectMake((self.view.bounds.size.width / 2) - 20, ((self.view.bounds.size.height / 4) * 3) - 40, 40, 40)];
    [arrowUp addTarget:self action:@selector(arrowUpFunc) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:arrowUp];

    UIButton *arrowBottom = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowBottom setImage:[UIImage imageNamed:@"arrowBottom.png"] forState:UIControlStateNormal];
    [arrowBottom setFrame:CGRectMake((self.view.bounds.size.width / 2) - 20, ((self.view.bounds.size.height / 4) * 3) + 40, 40, 40)];
    [arrowBottom addTarget:self action:@selector(arrowBottomFunc) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:arrowBottom];

    UIButton *arrowLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowLeft setImage:[UIImage imageNamed:@"arrowLeft.png"] forState:UIControlStateNormal];
    [arrowLeft setFrame:CGRectMake((self.view.bounds.size.width / 2) - 60, ((self.view.bounds.size.height / 4) * 3), 40, 40)];
    [arrowLeft addTarget:self action:@selector(arrowLeftFunc) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:arrowLeft];

    UIButton *arrowRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowRight setImage:[UIImage imageNamed:@"arrowRight.png"] forState:UIControlStateNormal];
    [arrowRight setFrame:CGRectMake((self.view.bounds.size.width / 2) + 20, ((self.view.bounds.size.height / 4) * 3), 40, 40)];
    [arrowRight addTarget:self action:@selector(arrowRightFunc) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:arrowRight];

    UIButton *startB = [UIButton buttonWithType:UIButtonTypeCustom];
    [startB setTitle:@"start" forState:UIControlStateNormal];
    [startB setFrame:CGRectMake((self.view.bounds.size.width - 160), (self.view.bounds.size.height - 40), 160, 40)];
    [startB addTarget:self action:@selector(startBFunc) forControlEvents:UIControlEventTouchUpInside];
    startB.backgroundColor = [UIColor blackColor];
    [[self view] addSubview:startB];

    UIButton *infoB = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoB setTitle:@"info" forState:UIControlStateNormal];
    [infoB setFrame:CGRectMake(0, (self.view.bounds.size.height - 40), 160, 40)];
    [infoB addTarget:self action:@selector(infoBFunc) forControlEvents:UIControlEventTouchUpInside];
    infoB.backgroundColor = [UIColor blackColor];
    [[self view] addSubview:infoB];

    self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, (self.view.bounds.size.width), self.view.bounds.size.width)];
    self.pickerview.delegate = self;
    self.pickerview.dataSource = self;
    [[self view] addSubview:self.pickerview];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void) arrowUpFunc {
    Cell *temp = [[Cell alloc] initWithArray:@[@"1", @"arrowTop.png"]];
    NSLog(@"Top");
    [self.dataList addObject:temp];
    [self.pickerview reloadAllComponents];
}

- (void) arrowRightFunc {
    Cell *temp = [[Cell alloc] initWithArray:@[@"2", @"arrowRight.png"]];
    NSLog(@"Right");
    [self.dataList addObject:temp];
    [self.pickerview reloadAllComponents];
}

- (void) arrowBottomFunc {
    Cell *temp = [[Cell alloc] initWithArray:@[@"3", @"arrowBottom.png"]];
    NSLog(@"Bottom");
    [self.dataList addObject:temp];
    [self.pickerview reloadAllComponents];
}

- (void) arrowLeftFunc {
    Cell *temp = [[Cell alloc] initWithArray:@[@"4", @"arrowLeft.png"]];
    NSLog(@"Left");
    [self.dataList addObject:temp];
    [self.pickerview reloadAllComponents];
}

- (void) startBFunc {
    RKMacroObject *macro = [RKMacroObject new];

    NSLog(@"start");
    for (int i = (int)(self.dataList.count - 1); i >= 0; i--) {
        Cell *temp = self.dataList[i];
        if ([temp.getDirection isEqualToString:@"1"]) {
            [macro addCommand:[RKMCRoll commandWithSpeed:1 heading:0.0 delay:3000]];
            NSLog(@"1");
        }
        else if ([temp.getDirection isEqualToString:@"2"]) {
            [macro addCommand:[RKMCRoll commandWithSpeed:1 heading:90.0 delay:3000]];
            NSLog(@"2");
        }
        else if ([temp.getDirection isEqualToString:@"3"]) {
            [macro addCommand:[RKMCRoll commandWithSpeed:1 heading:180.0 delay:3000]];
            NSLog(@"3");
        }
        else if ([temp.getDirection isEqualToString:@"4"]) {
            [macro addCommand:[RKMCRoll commandWithSpeed:1 heading:270.0 delay:3000]];
            NSLog(@"4");
        }
    }
    [robot playMacro:macro];
}

- (void) infoBFunc {
    NSLog(@"%@", robot.name);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataList.count;
}

// The data to return for the row and component (column) that's being passed in
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    row = self.dataList.count - row - 1;
    Cell *temp = self.dataList[row];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    iv.image = [UIImage imageNamed:temp.image];

    return iv;
}

- (void)moveToHeading:(float)heading velocity:(float)velocity {
    [robot driveWithHeading:heading andVelocity:velocity];
        //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(stop:) userInfo:nil repeats:NO];
}

- (void)stop:(NSTimer *)timer {
    [robot stop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end