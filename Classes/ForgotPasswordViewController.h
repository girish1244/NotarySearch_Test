//
//  ForgotPasswordViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ForgotPasswordViewController : UIViewController<UIAlertViewDelegate> {

	IBOutlet UITextField *txtEmail;
}

@property (nonatomic, retain) IBOutlet UITextField *txtEmail;

- (IBAction) submitClicked: (id) sender;
- (IBAction) backClicked: (id) sender;

@end
