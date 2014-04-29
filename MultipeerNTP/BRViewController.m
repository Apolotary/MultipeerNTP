//
//  BRViewController.m
//  MultipeerNTP
//
//  Created by Bektur Ryskeldiev on 4/24/14.
//  Copyright (c) 2014 Bektur Ryskeldiev. All rights reserved.
//

#import "BRViewController.h"
#import "BRAudioSyncConstants.h"
#import "BRConnectivityManager.h"
#import "NetworkClock.h"

@interface BRViewController () <MCBrowserViewControllerDelegate>
{
    BRConnectivityManager *_connectivityManager;
    NetworkClock *_networkClock;
    NSTimer *_mainTimer;
}

- (void) messageNotificationReceived: (NSNotification *) notification;
- (void) addObservers;
- (void) removeObservers;

@end

@implementation BRViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _connectivityManager = [BRConnectivityManager sharedInstance];
    [_connectivityManager startAdvertisingWithServiceType:kServiceType];
    
    _networkClock = [NetworkClock sharedInstance];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self addObservers];
    _mainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLocalTimeLabels) userInfo:nil repeats:YES];
    [_mainTimer fire];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self removeObservers];
    [_mainTimer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification methods

- (void) messageNotificationReceived: (NSNotification *) notification
{
    NSDictionary *messageDictionary = [notification.userInfo objectForKey:kNotificationMessageDictKey];
    NSDate *receivedDate = [notification.userInfo objectForKey:kNotificationMessageTimeKey];
    
    NSLog(@"Received message at: %@", receivedDate);
    
    NSString *remoteMessage = [messageDictionary objectForKey:kMessageCommandKey];
    
    if ([remoteMessage isEqualToString:kMessageCommandTime])
    {
        
    }
    else if ([remoteMessage isEqualToString:kMessageCommandStart])
    {
        
    }
    else if ([remoteMessage isEqualToString:kMessageCommandStop])
    {
        
    }
}

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageNotificationReceived:) name:kNotificationMessageReceived object:nil];
}

- (void) removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationMessageReceived object:nil];
}

#pragma mark - Time methods

- (void) updateLocalTimeLabels
{
    NSDate *systemTime = [NSDate date];
    NSDate *networkTime = [_networkClock networkTime];
    
    [_labelSystemTime setText:[NSString stringWithFormat:@"System Time: %@", systemTime]];
    [_labelNetworkTime setText:[NSString stringWithFormat:@"Network Time: %@", networkTime]];
    [_labelNetworkDelay setText:[NSString stringWithFormat:@"Device-Network Delay: %5.3f", [networkTime timeIntervalSinceDate:systemTime]]];
}

#pragma mark - Audio methods


#pragma mark - Button methods

- (IBAction)connectButtonPressed:(id)sender
{
    MCBrowserViewController *browserVC = [_connectivityManager getBrowserViewControllerForServiceType:kServiceType withDelegate:self];
    [self presentViewController:browserVC animated:YES completion:nil];
}

- (IBAction)startButtonPressed:(id)sender
{
    
}

- (IBAction)stopButtonPressed:(id)sender
{
    
}

- (IBAction)timeButtonPressed:(id)sender
{
    
}

#pragma mark - MCBrowserViewControllerDelegate methods

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
