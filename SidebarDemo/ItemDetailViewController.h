//
//  ItemDetailViewController.h
//  SidebarDemo
//
//  Created by Gracia Kartawidjaja on 24/10/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *itemLabel;
@property (nonatomic, strong) NSString *itemName;
@end
