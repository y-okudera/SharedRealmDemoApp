//
//  ExceptionHandler.h
//  SharedRealmDemoApp
//
//  Created by YukiOkudera on 2019/08/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExceptionHandler : NSObject

+ (BOOL)catchExceptionWithTryBlock:(__attribute__((noescape)) void(^ _Nonnull)(void))tryBlock
                             error:(NSError * _Nullable __autoreleasing * _Nullable)error;
@end

NS_ASSUME_NONNULL_END
