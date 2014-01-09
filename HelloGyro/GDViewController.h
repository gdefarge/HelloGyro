//
//  GDViewController.h
//  HelloGyro
//
//  Created by International on 1/8/14.
//  Copyright (c) 2014 GD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GDViewController : UIViewController
{
    // For the gyroscope
    CMMotionManager* motionManager;
    NSOperationQueue* operationQueue;
    NSTimer* timer;
}

@property (strong, nonatomic) IBOutlet UILabel *accelerationX;
@property (strong, nonatomic) IBOutlet UILabel *accelerationY;
@property (strong, nonatomic) IBOutlet UILabel *accelerationZ;
@property (strong, nonatomic) IBOutlet UILabel *gyroscopeRoll;
@property (strong, nonatomic) IBOutlet UILabel *gyroscopePitch;
@property (strong, nonatomic) IBOutlet UILabel *gyroscopeYaw;



@end
