//
//  ItemDetailViewController.m
//  SidebarDemo
//
//  Created by Gracia Kartawidjaja on 24/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
@synthesize itemLabel;
@synthesize itemName;

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
    itemLabel.text = itemName;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
