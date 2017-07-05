//
//  IPAddressUtil.m
//  CJBaseUtilDemo
//
//  Created by lichq on 5/26/15.
//  Copyright (c) 2015 lichq. All rights reserved.
//

#import "IPAddressUtil.h"

#import "arpa/inet.h"
#import "ifaddrs.h" //为了获取本地ip

@implementation IPAddressUtil

+ (NSString*)getIPAddress
{
    NSString* address;
    struct ifaddrs *interfaces = nil;
    
    // get all our interfaces and find the one that corresponds to wifi
    if (!getifaddrs(&interfaces))
    {
        for (struct ifaddrs* addr = interfaces; addr != NULL; addr = addr->ifa_next)
        {
            if (([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:@"en0"]) &&
                (addr->ifa_addr->sa_family == AF_INET))
            {
                struct sockaddr_in* sa = (struct sockaddr_in*) addr->ifa_addr;
                address = [NSString stringWithUTF8String:inet_ntoa(sa->sin_addr)];
                break;
            }
        }
    }
    freeifaddrs(interfaces);
    return address;
}

@end
