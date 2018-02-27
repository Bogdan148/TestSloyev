//
//  APIService.h
//  TestSloyev
//
//  Created by Bodya on 21.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class User;
@interface APIService : NSObject<NSURLSessionDelegate>

+ (instancetype)shared;
- (void)testRegistrate:(UIImage *)image;
- (void)registrateUser:(User *)user complition:(void(^)(NSURLResponse *response, NSError *error))complition;
@end
