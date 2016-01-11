//
//  main.m
//  BB-8 Tracer
//
//  Created by Kirax on 10/01/16.
//  Copyright © 2016 alexandrerichet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <RobotKit/RobotKit.h>
#import <RobotUIKit/RobotUIKit.h>

RKConvenienceRobot *robot;
RUICalibrateGestureHandler *calibrateHandler;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
