#import "Kiwi.h"
#import "BPAPIClient.h"
#import <AFHTTPRequestOperationLogger/AFHTTPRequestOperationLogger.h>

SPEC_BEGIN(KiwiBoilerplateApiSpec)

//https://github.com/allending/Kiwi/wiki/Up-and-Running-with-Kiwi-for-Mac

describe(@"Api",^{
    
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [[AFHTTPRequestOperationLogger sharedLogger] setLevel:AFLoggerLevelInfo];
    
    BPAPIClient *api = [BPAPIClient sharedClient];

    __block NSString *token = nil;
    __block id response = nil;
    
    void (^standardSuccess)(id responseObject) = ^(id responseObject){
        response = responseObject;
    };
    
    context(@"when querying for authorization", ^{
        
        beforeAll(^{
            response = nil;
        });
        
        it(@"should login with email and password and retrieve a token within 5 seconds", ^{
            [api loginWithEmail:@"test@example.com"
                       password:@"123123"
                        success:^(NSDictionary *responseObject){
                            token = responseObject[@"token"];
                        }];
            [[expectFutureValue(token) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        });

    });
    
});


SPEC_END