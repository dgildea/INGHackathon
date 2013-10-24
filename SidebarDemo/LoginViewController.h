//
//  LoginViewController.h
//  SidebarDemo
//
//  Created by Gracia Kartawidjaja on 22/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cif;
@property (weak, nonatomic) IBOutlet UITextField *pin;
@property (weak, nonatomic) IBOutlet UIButton *login;
- (IBAction)loginAction:(id)sender;

@end
