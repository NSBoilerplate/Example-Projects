//
//  BPAPICLient.m
//  Boilerplate
//
//  Created by Jeffrey Sambells on 2013-03-04.
//  Copyright (c) 2013 Boilerplate. All rights reserved.
//

#import "BPAPIClient.h"
#import <AFNetworking/AFNetworking.h>

#define _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_
#define AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES 1

typedef void(^StandardResponse)(id responseObject);

@interface NSURLRequest(Private)
+(void)setAllowsAnyHTTPSCertificate:(BOOL)inAllow forHost:(NSString *)inHost;
@end

@interface BPAPIClient()
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *email;
@end

@implementation BPAPIClient

+ (BPAPIClient *)sharedClient {
    static BPAPIClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:@"https://example.com"];
        [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        _sharedClient = [[self alloc] initWithBaseURL:url];
        [_sharedClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [_sharedClient setDefaultHeader:@"Accept" value:@"application/json"];
        
    });
    
    return _sharedClient;
}

#pragma mark - Authentication

- (void)loginWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(id responseObject))success
{
    [self postPath:@"login"
        parameters:@{@"email":email,@"password":password}
           success:^(AFHTTPRequestOperation *operation, id response) {
               if ([response[@"status"] isEqual:@"OK"]) {
                   self.token = response[@"response"][@"token"];
                   self.email = response[@"response"][@"email"];
                   success(response[@"response"]);
               }
           }
           failure:nil];
}

@end
