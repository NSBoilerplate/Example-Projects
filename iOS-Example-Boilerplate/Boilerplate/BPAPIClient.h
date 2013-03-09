//
//  BPAPICLient.h
//  Boilerplate
//
//  Created by Jeffrey Sambells on 2013-03-04.
//  Copyright (c) 2013 Boilerplate. All rights reserved.
//

#import "AFHTTPClient.h"

@interface BPAPIClient : AFHTTPClient

+ (BPAPIClient *)sharedClient;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(id responseObject))success;

@end
