//
//  User.m
//  TestSloyev
//
//  Created by Bodya on 23.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)createUserWithEmail:(NSString *)email password:(NSString *)password image:(UIImage *)image {
    User *user = [[User alloc] init];
    user.email = email;
    user.password = password;
    user.image = image;
    
    return user;
}

- (NSString *)stringGender {
    if (self.gender == male) {
        return @"male";
    } else if (self.gender == female) {
        return @"female";
    }
    return @"";
}

- (NSString *)stringBirthday {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    
    return [formatter stringFromDate:self.birthday];
}

- (void)cashedImage {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(self.image)];
    [userDefaults setObject:data forKey:@"sloyev.image"];
}

- (void)getImage {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"sloyev.image"];
    self.image = [UIImage imageWithData:data];
    
}

@end
