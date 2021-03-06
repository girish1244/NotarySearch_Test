//
//  RestaurantDetailViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import <MessageUI/MessageUI.h>

@class ASIFormDataRequest;
@class Restaurant;
@class ApunKaBazarAppDelegate;
@interface RestaurantDetailViewController : UIViewController <ASIHTTPRequestDelegate, UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate, MFMailComposeViewControllerDelegate>
{
	UIImageView *imgView;
	UILabel *lblAddress;
	UILabel *lblPhoneno;
	UILabel *lblDistance;
	UILabel *EmailLabel;
	UILabel *WebSiteLabel;
	UITableView *tblView;
	
	NSString *menuItemName;
	UILabel *menuNameLabel;
	
	Restaurant *thisRestaurant;
	
	UIImageView *star1;
	UIImageView *star2;
	UIImageView *star3;
	UIImageView *star4;
	UIImageView *star5;
	
	UIImageView *otherImage1;
	UIImageView *otherImage2;
	UIImageView *otherImage3;
	
	UIScrollView *ImageScrollView;
	
	ASIFormDataRequest *imgRequest;
	ApunKaBazarAppDelegate *appDelegate;
	NSMutableDictionary *facilityImageRequests;
	
	UIActivityIndicatorView *activityIndicator;
	
	NSTimer *addsTimer;
	int count;
	UIImageView *AddImageView;
	
	UILabel *deScriptionLabel;
	UIButton *Addbutton;
	
	
	
}
@property(nonatomic,retain)IBOutlet UIButton *Addbutton;
@property(nonatomic,retain)IBOutlet UILabel *deScriptionLabel;

@property(nonatomic,retain)IBOutlet UIImageView *AddImageView;
@property(nonatomic,retain)NSTimer *addsTimer;
@property(nonatomic,readwrite)int count;
@property (nonatomic, retain) NSMutableDictionary *facilityImageRequests;
@property (nonatomic, retain) IBOutlet UILabel *WebSiteLabel;
@property (nonatomic, retain) IBOutlet UILabel *EmailLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *ImageScrollView;

@property (nonatomic, retain) IBOutlet UIImageView *star1;
@property (nonatomic, retain) IBOutlet UIImageView *star2;
@property (nonatomic, retain) IBOutlet UIImageView *star3;
@property (nonatomic, retain) IBOutlet UIImageView *star4;
@property (nonatomic, retain) IBOutlet UIImageView *star5;

@property (nonatomic, retain) IBOutlet UIImageView *otherImage1;
@property (nonatomic, retain) IBOutlet UIImageView *otherImage2;
@property (nonatomic, retain) IBOutlet UIImageView *otherImage3;

@property (nonatomic, retain) NSString *menuItemName;
@property (nonatomic, retain) IBOutlet UILabel *menuNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *lblDistance;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UILabel *lblAddress;
@property (nonatomic, retain) IBOutlet UILabel *lblPhoneno;

@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic, retain) Restaurant *thisRestaurant;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

-(IBAction)backClicked:(id) sender;

- (IBAction) openWebsite: (id) sender;
- (IBAction) callNow: (id) sender;
- (IBAction) emailNow: (id) sender;
-(IBAction)HomeButtonPressed:(id)sender;
-(IBAction)ADDPressed:(id)sender;


@end
