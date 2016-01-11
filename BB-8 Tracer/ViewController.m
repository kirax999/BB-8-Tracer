//
//  ViewController.m
//  BB-8 Tracer
//
//  Created by Alexandre Richet on 08/01/16.
//  Copyright © 2016 Alexandre Richet. All rights reserved.
//

#import "ViewController.h"
#import "global.h"

extern RKConvenienceRobot *robot;

@interface ViewController ()

@end

@implementation ViewController
/*
@synthesize robot;
@synthesize calibrateHandler;
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    int ladder = self.view.bounds.size.width;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    calibrateHandler = [[RUICalibrateGestureHandler alloc] initWithView:self.view];
    [[RKRobotDiscoveryAgent sharedAgent] addNotificationObserver:self selector:@selector(handleRobotStateChangeNotification:)];

    UIImageView *mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ladder, ladder)];
    mainImage.image = [UIImage imageNamed:@"bb-8.png"];
    [self.view addSubview:mainImage];
    
    self.activitySearch = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activitySearch.frame = CGRectMake((ladder / 2) - 40, ladder + 70, 80, 80);
    [self.view addSubview:self.activitySearch];

    self.loadText = [[UITextField alloc] initWithFrame:CGRectMake(0, ladder + 10, self.view.bounds.size.width, 80)];
    self.loadText.textAlignment = NSTextAlignmentCenter;
    self.loadText.text = @"Wait BB-8";
    [self.view addSubview:self.loadText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    [self.activitySearch startAnimating];
    [RKRobotDiscoveryAgent startDiscovery];
}

- (void)appWillResignActive:(NSNotification *)notification {
    [self.activitySearch stopAnimating];
    [RKRobotDiscoveryAgent stopDiscovery];
    [RKRobotDiscoveryAgent disconnectAll];
}

- (void)handleRobotStateChangeNotification:(RKRobotChangedStateNotification *)notification {
    switch (notification.type) {
        case RKRobotConnecting:
            break;
        case RKRobotOnline:
            robot = [[RKOllie alloc] initWithRobot:notification.robot];
            [calibrateHandler setRobot:robot.robot];
            NSLog(@"BOT befor: %@", robot);
            [self performSegueWithIdentifier:@"connectL" sender:self];
            break;
        case RKRobotDisconnected:
            [calibrateHandler setRobot:nil];
            robot = nil;
            [RKRobotDiscoveryAgent startDiscovery];
            break;
        default:
            break;
    }
}

- (IBAction)stopPressed:(id)sender {
    [robot stop];
}

- (IBAction)zeroPressed:(id)sender {
    [self moveToHeading:0.0 velocity:0.3];
}

- (IBAction)ninetyPressed:(id)sender {
    [self moveToHeading:90.0 velocity:0.3];
}

- (IBAction)oneEightyPressed:(id)sender {
    [self moveToHeading:180.0 velocity:0.3];
}

- (IBAction)twoSeventyPressed:(id)sender {
    [self moveToHeading:270.0 velocity:0.3];
}

-(void)moveToHeading:(float)heading velocity:(float)velocity {
    [robot driveWithHeading:heading andVelocity:velocity];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(stop:) userInfo:nil repeats:NO];
}
/*
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
 UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
 CGPoint currentPos = [myTouch locationInView: self.mapView];
 if (currentPos.x < self.mapView.bounds.size.height && currentPos.y < self.mapView.bounds.size.width &&
 currentPos.x > 0 && currentPos.y > 0)
 NSLog(@"Point in myView: (%f,%f)", currentPos.x, currentPos.y);
 }
 */
-(void)stop:(NSTimer *)timer {
    [robot stop];
}

/* *************** switch view ***************** */
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}
*/

@end