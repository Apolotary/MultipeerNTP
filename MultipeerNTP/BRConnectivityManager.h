//
//  BRConnectivityManager.h
//  BRAudioSync
//
//  Created by Bektur Ryskeldiev on 3/29/14.
//  Copyright (c) 2014 Bektur Ryskeldiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>


@interface BRConnectivityManager : NSObject

+ (BRConnectivityManager *)sharedInstance;

- (MCBrowserViewController *)getBrowserViewControllerForServiceType:(NSString *) serviceType
                                                       withDelegate:(id<MCBrowserViewControllerDelegate>) delegate;

- (void)startAdvertisingWithServiceType:(NSString *) serviceType;
- (void)stopAdvertising;

- (NSArray *)connectedPeers;

- (void)sendOutputStream:(NSOutputStream *) stream toPeer:(MCPeerID *)peer;

- (void)sendMessage: (NSString *) message
    withNetworkTime: (NSDate *) networkTime;

@end
