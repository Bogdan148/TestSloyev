//
//  ViewController.m
//  TestSloyev
//
//  Created by Bodya on 20.02.2018.
//  Copyright © 2018 Bodya. All rights reserved.
//

#import "AuthViewController.h"
#import "GradientButton.h"
#import "APIService.h"
#import "UIViewController+Validator.h"
#import "RegistrateViewController.h"
@interface AuthViewController ()

@property (weak, nonatomic) IBOutlet GradientButton *singUpButton;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text = @"У вас еще нет аккаунта? Зарегистрироваться";
    NSString *boldText = @"Зарегистрироваться";

    NSRange rangeBoldText = [text rangeOfString:boldText];
    NSMutableAttributedString *mutableAttStr = [[NSMutableAttributedString alloc] initWithString:text];

    [mutableAttStr addAttribute:NSFontAttributeName
                          value:[UIFont boldSystemFontOfSize:15]
                          range:rangeBoldText];

    [self.singUpButton setAttributedTitle:mutableAttStr forState:UIControlStateNormal];
    self.singUpButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.singUpButton.titleLabel.textColor = [UIColor whiteColor];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RegistrateViewController *vc = [segue destinationViewController];
    vc.state = registrationState;
}

- (IBAction)singInAction:(id)sender {
    if ([self validateWithAlertEmail:self.loginTextField.text password:self.passwordTextField.text]) {
        RegistrateViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
        vc.state = profileState;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
