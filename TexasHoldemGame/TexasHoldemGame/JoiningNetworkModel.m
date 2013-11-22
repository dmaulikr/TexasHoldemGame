//
//  JoiningNetworkModel.m
//  TexasHoldemGame
//
//  Created by Jakub Sokolowski on 20/11/2013.
//  Copyright (c) 2013 WUT. All rights reserved.
//

#import "JoiningNetworkModel.h"

@implementation JoiningNetworkModel

-(void)startHostsSearching
{
    [self configureSessionDetails];
    self.nearbyServiceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID
                                                                 serviceType:kServiceType];
    self.nearbyServiceBrowser.delegate = self;
    [self.nearbyServiceBrowser startBrowsingForPeers];
}

-(NSMutableArray*)availableHosts
{
    if (!_availableHostsNames) {
        _availableHostsNames = [[NSMutableArray alloc]init];
    }
    return _availableHostsNames;
}

#pragma mark - MCNearbyServiceBrowserDelegate methods

-(void)browser:(MCNearbyServiceBrowser *)browser
     foundPeer:(MCPeerID *)peerID
withDiscoveryInfo:(NSDictionary *)info
{
    [self.availableHosts addObject:peerID.displayName];
    [self.delegate listOfAvailableHostsDidChange];
}


-(void)browser:(MCNearbyServiceBrowser *)browser
      lostPeer:(MCPeerID *)peerID
{
    for (NSString* peerName in self.availableHosts) {
        if ([peerName isEqualToString:peerID.displayName]) {
            [self.availableHosts removeObject:peerName];
            break;
        }
    }
    [self.delegate listOfAvailableHostsDidChange];
}


@end
