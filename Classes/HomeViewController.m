//
//  HomeViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "ApunKaBazarAppDelegate.h"
#import "LoginViewController.h"

#import "ASIFormDataRequest.h"
#import "JSON.h"

#import "CategoryMenuViewController.h"

#import<QuartzCore/QuartzCore.h>
#import "AsynchronousImageDownload.h"
#import "Category.h"
#import "Facility.h"

@interface HomeViewController ()
- (void)startIconDownload:(id) object forElement:(int)element;
- (void)loadImagesForOnscreenRows;
- (void)appImageDidLoad:(int)element;
@end


@implementation HomeViewController

@synthesize categoryMenuViewController;
@synthesize titleline;
@synthesize categoryArray;
@synthesize scrollView;

@synthesize imageDownloadsInProgress;
@synthesize activityIndicator;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	self.navigationController.navigationBarHidden=YES;
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.titleline.text=@"Categories";
	self.titleline.font=[UIFont boldSystemFontOfSize:17];
	self.titleline.textColor=[UIColor blueColor];
	titleline.textAlignment = UITextAlignmentCenter;
	
	
	NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
	self.imageDownloadsInProgress=dict;
	[dict release];
	
	UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 230, 20, 20)];
	[activity setHidesWhenStopped:YES];
	[activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	self.activityIndicator=activity;
	[self.view addSubview:self.activityIndicator];
	[activity release];
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
	
	
	NSLog(@"Home View Controller");
	[super viewWillAppear:animated];
	
	[self.categoryArray removeAllObjects];

	NSArray *iconDownloaders = [imageDownloadsInProgress allValues];
	[iconDownloaders makeObjectsPerformSelector:@selector(cancelDownload)];
	[self.imageDownloadsInProgress removeAllObjects];
	
	[self clearScollView];
	
	[self.activityIndicator startAnimating];
	[self performSelector:@selector(getData) withObject:nil afterDelay:0.2];
	//[self getData];
	//[self createScrollView];
}

- (IBAction) backClicked: (id) sender{

	//show login screen
	LoginViewController *lViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
	appDelegate.loginViewController=lViewController;
	[appDelegate.window addSubview:appDelegate.loginViewController.view];
	[lViewController release];
	
}

-(void) clearScollView{

	for(UIView *subview in self.scrollView.subviews){
	
		[subview removeFromSuperview];
	}
}


/*
- (void) createScrollView
{
	
	
	NSLog(@"in create scrollview");
	
	//add views to scrolview
	
	int x=40;
	int y=10;
	
	
	
	
	for (int i=0;i<[self.categoryArray count];i++) 
		//for (i = 0 ;i<loadingImagesCount ; i++) 
	{
		
		Category *category=[self.categoryArray objectAtIndex:i];
		//User *user=[self.usersArray objectAtIndex:i];
		//Member *user=[self.usersArray objectAtIndex:currViewIndex+i];
		
		UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(x, y, 100, 130)];
		//UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(currViewX, currViewY, 80, 95)];
		
		userView.tag=i;
		
		UIImageView *backgroundImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 95)];
		[backgroundImgView setImage:[UIImage imageNamed:@"category.png"]];
		backgroundImgView.tag=1;
		
		///////////// round corners of image//////////
		
		//CALayer *imageLayer = [CALayer layer];
		//			imageLayer.frame =  CGRectMake(0,0, 67, 80);
		//			imageLayer.cornerRadius = 5.0;
		//			//UIImage *img=[self.imageViewArray objectAtIndex:i];
		//			//imageLayer.contents = (id)img.CGImage;
		//			imageLayer.masksToBounds =YES;
		
		
		
		//////////// end round corners /////////////
		
		UIButton *userButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 87,81)]; 
		//[userButton setImage:[self.imageViewArray objectAtIndex:i] forState:UIControlStateNormal];
		//[userButton.layer addSublayer:imageLayer];
		
		///////////////[self startIconDownload:user forElement:i];
		
		[userButton addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
		userButton.tag=i;
		
		//CGPoint center=self.view.center;
		UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		
		//activity.center = self.view.center;
		//activity.center=CGPointMake(userView.center.x, userView.center.y);
		//activity.frame=CGRectMake(center.x,center.y,20,20);
		activity.frame=CGRectMake(40, 35, 22, 20);
		activity.hidesWhenStopped=YES;
		[activity startAnimating];
		
		
		UILabel *userLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 95, 100, 40)];
		userLabel.text=category.categoryName;
		NSLog(@"category Name:%@",category.categoryName);
		userLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
		[userLabel setNumberOfLines:3];
		[userLabel setBackgroundColor:[UIColor clearColor]];
		userLabel.textColor=[UIColor blueColor];
		userLabel.textAlignment=UITextAlignmentCenter;
		//show a label for unread messages
		//UILabel *unreadlabel=[[UILabel alloc] initWithFrame:CGRectMake(45, 5, 15, 15)];
		//			unreadlabel.font=[UIFont fontWithName:@"Helvetica" size:12];
		//			unreadlabel.tag=i;
		//			[unreadlabel setBackgroundColor:[UIColor whiteColor]];
		//			[unreadlabel setTextColor:[UIColor blackColor]];
		
		[userView addSubview:backgroundImgView];
		[userView addSubview:userButton];
		[userView addSubview:userLabel];
		//[userView addSubview:unreadlabel];
		[userView addSubview:activity];
		
		
		
		[self.scrollView addSubview:userView];
		
		[activity release];
		[userLabel release];
		//[unreadlabel release];
		[userButton release];
		[backgroundImgView release];
		[userView release];
		
		x+=130;
		//currViewX+=81;
		if ((i+1)%2==0) 
			//if(currViewX>260)
		{
			//if added image is 4 th image
			y+=140;
			x=40;
			//currViewY+=100;
			//currViewX=3;
		}
		
	}
	//	i--;
	if (y+100>self.scrollView.frame.size.height) {
		self.scrollView.contentSize=CGSizeMake(280, y+150);
	}
	else {
		//self.scrollView.contentSize=CGSizeMake(320, self.scrollView.frame.size.height+60);
	}
	
	
	
	for (int i=0; i<[self.categoryArray count]; i++) {
		[self startIconDownload:[self.categoryArray objectAtIndex:i] forElement:i];
	}
	
	
}
*/




- (void) createScrollView
{
	
	
	NSLog(@"in create scrollview");
	
	//add views to scrolview
	
	int x=0;
	int y=10;
	
	
	
	
	for (int i=0;i<[self.categoryArray count];i++) 
		//for (i = 0 ;i<loadingImagesCount ; i++) 
	{
		
		Category *category=[self.categoryArray objectAtIndex:i];
		//User *user=[self.usersArray objectAtIndex:i];
		//Member *user=[self.usersArray objectAtIndex:currViewIndex+i];
		
		UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(x, y, 100, 130)];
		
		//UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(currViewX, currViewY, 80, 95)];
		
		userView.tag=i;
		
		UIImageView *backgroundImgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 95)];
		[backgroundImgView setImage:[UIImage imageNamed:@"category.png"]];
		backgroundImgView.tag=1;
		
		///////////// round corners of image//////////
		
		//CALayer *imageLayer = [CALayer layer];
		//			imageLayer.frame =  CGRectMake(0,0, 67, 80);
		//			imageLayer.cornerRadius = 5.0;
		//			//UIImage *img=[self.imageViewArray objectAtIndex:i];
		//			//imageLayer.contents = (id)img.CGImage;
		//			imageLayer.masksToBounds =YES;
		
		
		
		//////////// end round corners /////////////
		
		UIButton *userButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 5, 87,81)]; 
		//[userButton setImage:[self.imageViewArray objectAtIndex:i] forState:UIControlStateNormal];
		//[userButton.layer addSublayer:imageLayer];
		
		///////////////[self startIconDownload:user forElement:i];
		
		[userButton addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
		userButton.tag=i;
		
		//CGPoint center=self.view.center;
		UIActivityIndicatorView *activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
		
		//activity.center = self.view.center;
		//activity.center=CGPointMake(userView.center.x, userView.center.y);
		//activity.frame=CGRectMake(center.x,center.y,20,20);
		activity.frame=CGRectMake(40, 35, 22, 20);
		activity.hidesWhenStopped=YES;
		[activity startAnimating];
		
		
		UILabel *userLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 95, 100, 20)];
		userLabel.text=category.categoryName;
		NSLog(@"category Name:%@",category.categoryName);
		userLabel.font=[UIFont fontWithName:@"Helvetica" size:16];
		[userLabel setNumberOfLines:3];
		[userLabel setBackgroundColor:[UIColor clearColor]];
		userLabel.textColor=[UIColor blueColor];
		userLabel.textAlignment=UITextAlignmentCenter;
		NSLog(@"in cell for row at index      1");
		//show a label for unread messages
		//UILabel *unreadlabel=[[UILabel alloc] initWithFrame:CGRectMake(45, 5, 15, 15)];
		//			unreadlabel.font=[UIFont fontWithName:@"Helvetica" size:12];
		//			unreadlabel.tag=i;
		//			[unreadlabel setBackgroundColor:[UIColor whiteColor]];
		//			[unreadlabel setTextColor:[UIColor blackColor]];
		
		[userView addSubview:backgroundImgView];
		[userView addSubview:userButton];
		[userView addSubview:userLabel];
		//[userView addSubview:unreadlabel];
		[userView addSubview:activity];
		
		
		
		[self.scrollView addSubview:userView];
		
		[activity release];
		[userLabel release];
		//[unreadlabel release];
		[userButton release];
		[backgroundImgView release];
		[userView release];
		
		x+=100;
		//currViewX+=81;
		if ((i+1)%3==0) 
			//if(currViewX>260)
		{
			//if added image is 4 th image
			y+=120;
			x=0;
			//currViewY+=100;
			//currViewX=3;
		}
		
	}
	//	i--;
	if (y+100>self.scrollView.frame.size.height)
	{
		self.scrollView.contentSize=CGSizeMake(260, y+120);
	}
	else {
		//self.scrollView.contentSize=CGSizeMake(320, self.scrollView.frame.size.height+60);
	}
	
	
	
	for (int i=0; i<[self.categoryArray count]; i++)
	{
		[self startIconDownload:[self.categoryArray objectAtIndex:i] forElement:i];
	}
	
	
}












- (void) getData{
	
	//http://www.myappdemo.com/ApunKaBazaar/services/getcategory.php
	NSString *urlString1=[NSString stringWithFormat:@"%@getcategory.php",URLprefix];
	NSLog(@"%@",urlString1);
	NSURL *url1=[[NSURL alloc] initWithString:urlString1];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
	
	//[request setPostValue:self.categoryId forKey:@"catid"];
	[request setDelegate:self];
	[request startSynchronous];
	
	[url1 release];
	NSError *error = [request error];
	if (!error) 
	{
		NSString *response = [request responseString];
		NSLog(@"response:%@",response);
		NSData *responseData=[request responseData];
		NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		
		NSArray *results = [responseString JSONValue];
		[responseString release];
		
		NSMutableArray *array=[[NSMutableArray alloc] init];
		
		for (NSDictionary *dict in results) 
		{
			Category *category=[[Category alloc] init];
			category.categotyId=[dict objectForKey:@"CategoryId"];
			category.categoryName=[dict objectForKey:@"CategoryName"];
			category.imgURL=[dict objectForKey:@"Picture"];
			category.specialitiesName=[dict objectForKey:@"SubCategory"];
			
			//get facilities
			NSMutableArray *facArray=[[NSMutableArray alloc] init];
			NSArray *facDataArray=[dict objectForKey:@"Facilities"];
			for (NSDictionary *facDict in facDataArray) 
			{
				Facility *facility=[[Facility alloc] init];
                [facility setFacilityName:[facDict objectForKey:@"ServiceName"]];
				[facility setFacilityImgURL:[facDict objectForKey:@"ServiceImage"]];
				[facArray addObject:facility];
				[facility release];
			}
			[category setFacilitiesArray:facArray];
			NSLog(@"FAcilities array count in category is %d,in facarray is %d",[category.facilitiesArray count],[facArray count]);
			//category.facilitiesArray=facArray;
			[facArray release];
			[array addObject:category];
			
			[category release];
		}
		
		self.categoryArray=array;
		
		[array release];
	}		
	//NSLog(@"count:%d",[self.categoryArray count]);
	//NSLog(@"count:%d",[self.categoryArray count]);
	
	[self createScrollView];
	[self.activityIndicator stopAnimating];
}


- (IBAction) categoryClicked: (id) sender
{
	

	CategoryMenuViewController *categoryViewController=[[CategoryMenuViewController alloc] initWithNibName:@"CategoryMenuViewController" bundle:nil];
	appDelegate.selectedCategory=(Category *)[self.categoryArray objectAtIndex:[sender tag]];
	NSLog(@"------%@",appDelegate.selectedCategory.categoryName);
	//categoryViewController.categoryId=@"1";
	//categoryViewController.categoryName=@"Restaurants";
	self.categoryMenuViewController =categoryViewController;
	[self.navigationController pushViewController:self.categoryMenuViewController animated:YES];
	[categoryViewController release];
}

- (void)startIconDownload:(id) object forElement:(int)element
{
	AsynchronousImageDownload *iconDownloader = [imageDownloadsInProgress objectForKey:[NSString stringWithFormat:@"%d",element]];
    if (iconDownloader == nil)
    {
        iconDownloader = [[AsynchronousImageDownload alloc] init];
		[iconDownloader setValue:[(Category *)object imgURL] forKey:@"pictureURL"];
        iconDownloader.elementNo = element;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:[NSString stringWithFormat:@"%d",element]];
        [iconDownloader startDownload];
        [iconDownloader release];
    }
	
}


- (void)appImageDidLoad:(int)element{
	
	NSLog(@"appImage: ImageDidLoad for element %d",element);
	AsynchronousImageDownload *iconDownloader = [imageDownloadsInProgress objectForKey:[NSString stringWithFormat:@"%d",element]];
	if (iconDownloader != nil)
	{
		UIView *aView=[self.scrollView.subviews objectAtIndex:element];
		for (UIView *subView in aView.subviews) 
		{
			if([subView isKindOfClass:[UIButton class]])
			{
				UIButton *btn=(UIButton *)subView;
				
				//create round rect images
				CALayer *imageLayer = [CALayer layer];
				imageLayer.frame =  CGRectMake(0,0, 87, 81);
				imageLayer.cornerRadius = 8.0;
				imageLayer.contents=(id)iconDownloader.image.CGImage;
				imageLayer.masksToBounds =YES;
				
				[btn.layer addSublayer:imageLayer];
			}
			else if([subView isKindOfClass:[UIActivityIndicatorView class]])
			{
				UIActivityIndicatorView *tempactivity=(UIActivityIndicatorView *)subView;
				[tempactivity stopAnimating];
			}
			
		}
	}
	
}

- (void)viewDidDisappear:(BOOL)animated
{
//	NSArray *iconDownloaders = [imageDownloadsInProgress allValues];
//	[iconDownloaders makeObjectsPerformSelector:@selector(cancelDownload)];
	[self.imageDownloadsInProgress removeAllObjects];
	[super viewDidDisappear:animated];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	NSArray *iconDownloaders = [imageDownloadsInProgress allValues];
	[iconDownloaders makeObjectsPerformSelector:@selector(cancelDownload)];
	[imageDownloadsInProgress release];
	
	[activityIndicator reloadInputViews];
	[scrollView release];
	[categoryArray release];
	[categoryMenuViewController release];
	
    [super dealloc];
}


@end
