//
//  LoginViewController.m
//  SidebarDemo
//
//  Created by Gracia Kartawidjaja on 22/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMain"])
    {
        SWRevealViewController *mainController = (SWRevealViewController*)segue.destinationViewController;
    }
}

- (IBAction)loginAction:(id)sender {
    [self.cif resignFirstResponder];
    [self.pin resignFirstResponder];
    if([self.pin.text isEqualToString:@"1111"])
    {
        [self performSegueWithIdentifier: @"showMain" sender: self];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Incorrect PIN!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [errorAlert show];
        
    }
    
}

-(void)dismissKeyboard {
    [self.cif resignFirstResponder];
    [self.pin resignFirstResponder];
}
@end
