//
//  CategoryMenuListViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDownloader.h"
#import "IconDownloader.h"

@class CategoryMenu;
@class CategoryMenuListCell;
@class ApunKaBazarAppDelegate;
@interface CategoryMenuListViewController : UIViewController<IconDownloaderDelegate,IconDownloaderDelegate,UISearchBarDelegate> {

	UITableView *tblView;

	
	NSTimer *addsTimer;
     int count;
	NSString *categoryid;
	NSString *categoryName;
	CategoryMenu *selectedCategoryMenu;
	
	UILabel *menuLabel;
	
	CategoryMenuListCell *tblCell;
	
	NSMutableArray *listArray;
	
	NSMutableDictionary *imageDownloadsInProgress; 
	UILabel *titleheadline;
	
	ApunKaBazarAppDelegate *appDelegate;
	UIImageView *AddImageView;
	UIActivityIndicatorView *activityIndicator;
	UISearchBar *searchBar;
	BOOL isSearching;
	UILabel *deScriptionLabel;
	UIButton *Addbutton;
	
	
}
@property(nonatomic,retain)IBOutlet UIButton *Addbutton;
@property(nonatomic,retain)IBOutlet UILabel *deScriptionLabel;
@property(nonatomic,readwrite)BOOL isSearching;
@property(nonatomic,retain)IBOutlet UISearchBar *searchBar;
@property(nonatomic,retain)IBOutlet UIImageView *AddImageView;
@property(nonatomic,retain)NSTimer *addsTimer;
@property(nonatomic,readwrite)int count;
@property(nonatomic,retain)IBOutlet UILabel *titleheadline;
@property (nonatomic, retain) IBOutlet UITableView *tblView;

@property (nonatomic, retain) NSString *categoryid;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) CategoryMenu *selectedCategoryMenu;

@property (nonatomic, retain) IBOutlet UILabel *menuLabel;

@property (nonatomic, retain) IBOutlet CategoryMenuListCell *tblCell;

@property (nonatomic, retain) NSMutableArray *listArray;

@property(nonatomic,retain)NSMutableDictionary *imageDownloadsInProgress; 

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void) getData;
-(IBAction)back;
-(IBAction)HomeButtonPressed:(id)sender;
-(IBAction)ADDPressed:(id)sender;

@end
