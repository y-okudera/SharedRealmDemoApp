//
//  ExceptionHandler.m
//  SharedRealmDemoApp
//
//  Created by YukiOkudera on 2019/08/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import "ExceptionHandler.h"

@implementation ExceptionHandler
+ (BOOL)catchExceptionWithTryBlock:(__attribute__((noescape)) void(^ _Nonnull)(void))tryBlock
                             error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    @try {
        tryBlock();
        return YES;
    } @catch (NSException *exception) {
#if DEBUG
        NSLog(@"例外発生!: %@", exception);
#endif
        NSString *domain = [NSString stringWithFormat:@"%@.ExceptionHandler", [NSBundle mainBundle].bundleIdentifier];
        NSMutableDictionary * info = [NSMutableDictionary dictionary];
        info[@"ExceptionName"] = exception.name;
        info[@"ExceptionReason"] = exception.reason;
        info[@"ExceptionCallStackReturnAddresses"] = exception.callStackReturnAddresses;
        info[@"ExceptionCallStackSymbols"] = exception.callStackSymbols;
        info[@"ExceptionUserInfo"] = exception.userInfo;
        *error = [[NSError alloc] initWithDomain:domain code:-9999 userInfo:info];
        return NO;
    }
}
@end
