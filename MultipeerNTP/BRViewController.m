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
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self removeObservers];
    [_networkClock finishAssociations];
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
