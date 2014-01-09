//
//  GDViewController.m
//  HelloGyro
//
//  Created by International on 1/8/14.
//  Copyright (c) 2014 GD. All rights reserved.
//

#import "GDViewController.h"

@interface GDViewController ()

@end

@implementation GDViewController
@synthesize accelerationX;
@synthesize accelerationY;
@synthesize accelerationZ;
@synthesize gyroscopeRoll;
@synthesize gyroscopePitch;
@synthesize gyroscopeYaw;

#define degrees(x) (180 * x / M_PI)

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize the management of the Core Motion (accelerometer and gyroscope
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager)
    {
        motionManager.deviceMotionUpdateInterval = 1/60; // refresh frequency
        [motionManager startDeviceMotionUpdates];
    }
    
    // Start timer to call the method read which will do the updates
    timer = [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(read) userInfo:nil repeats:YES];
    
    // Check the gyroscope
    if ([motionManager isGyroAvailable]) // Has the device a gyro
    {
        if (![motionManager isGyroActive]) // Did the activation of the gyro worked?
        {
            [motionManager setGyroUpdateInterval:0.1];
            [motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
                NSString* x = [[NSString alloc] initWithFormat:@"%.02f", gyroData.rotationRate.x];
                accelerationX.text = x;
                NSString* y = [[NSString alloc] initWithFormat:@"%.02f", gyroData.rotationRate.y];
                accelerationY.text = y;
                NSString* z = [[NSString alloc] initWithFormat:@"%.02f", gyroData.rotationRate.z];
                accelerationZ.text = z;
            }];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)read
{
    CMAttitude* attitude;
    CMDeviceMotion* motion = motionManager.deviceMotion;
    attitude = motion.attitude;

    NSString* roll = [[NSString alloc] initWithFormat:@"Roll: %f", degrees(attitude.roll)];
    NSString* pitch = [[NSString alloc] initWithFormat:@"Pitch: %f", degrees(attitude.pitch)];
    NSString* yaw = [[NSString alloc] initWithFormat:@"Yaw: %f", degrees(attitude.yaw)];
    
    gyroscopeRoll.text = roll;
    gyroscopePitch.text = pitch;
    gyroscopeYaw.text = yaw;
    
}

@end
