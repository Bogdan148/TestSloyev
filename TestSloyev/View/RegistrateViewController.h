//
//  RegistrateViewController.h
//  TestSloyev
//
//  Created by Bodya on 21.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    defaultState,
    profileState,
    registrationState
}ViewState;

@class User;
@interface RegistrateViewController : UIViewController

@property (nonatomic) ViewState state;
@property (nonatomic) User *user;
@end
