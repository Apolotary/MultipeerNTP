//
//  BRViewController.h
//  MultipeerNTP
//
//  Created by Bektur Ryskeldiev on 4/24/14.
//  Copyright (c) 2014 Bektur Ryskeldiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRViewController : UIViewController
{
    IBOutlet UILabel *_labelSystemTime;
    IBOutlet UILabel *_labelNetworkTime;
    IBOutlet UILabel *_labelNetworkDelay;
    IBOutlet UILabel *_labelStreamingSourceTime;
    IBOutlet UILabel *_labelStreamingSourceDelay;
}

- (IBAction)connectButtonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)timeButtonPressed:(id)sender;

@end
