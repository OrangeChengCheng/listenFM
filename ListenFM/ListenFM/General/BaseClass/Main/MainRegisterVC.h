//
//  MainRegisterVC.h
//  ListenFM
//
//  Created by lanouhn on 16/3/23.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainRegisterVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passwork;
@property (strong, nonatomic) IBOutlet UITextField *passworkAgain;
@property (strong, nonatomic) IBOutlet UITextField *eMail;
@property (strong, nonatomic) IBOutlet UITextField *phone;

@end
