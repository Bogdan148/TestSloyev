//
//  UIViewController+Validator.h
//  TestSloyev
//
//  Created by Bodya on 24.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Validator)

- (BOOL)validateWithAlertEmail:(NSString *)email password:(NSString *)password;

@end
