//
//  Validator.h
//  TestSloyev
//
//  Created by Bodya on 23.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

+ (BOOL)validatePasswordString:(NSString *)string;
+ (BOOL)validateEmailString:(NSString *)string;
+ (BOOL)validateEmailString:(NSString *)string passwordString:(NSString *)password;
@end
