//
//  ForgotPasswordViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"

@implementation ForgotPasswordViewController
@synthesize txtEmail;

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
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[self.txtEmail becomeFirstResponder];
	[self.txtEmail setKeyboardAppearance:UIKeyboardAppearanceAlert];
	[self.txtEmail setKeyboardType:UIKeyboardTypeEmailAddress];
	
}


- (IBAction) submitClicked: (id) sender{
	
	//check email validity
	NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx]; 
	
	
	if ([txtEmail.text length]==0 || [emailTest evaluateWithObject:txtEmail.text] == NO) {
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" 
													  message:@"Please enter valid email" 
													 delegate:self 
											cancelButtonTitle:@"OK" 
											otherButtonTitles:nil];
		
		[alert setTag:1];
		[alert show];
		[alert release];
		
	}
	else {
		[self performSelector:@selector(submit) withObject:nil afterDelay:0.2];

	}

	
}

-(void) submit
{
	
	NSString *urlString1=[NSString stringWithFormat:@"%@forgotpassword.php",URLprefix];
	//NSURL *url=[[[NSURL alloc] initWithString:@"http://www.myappdemo.com/newapp/services/forgotpassword.php"] autorelease];

	NSURL *url1=[[NSURL alloc] initWithString:urlString1];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
	
	
	NSLog(@" Durin sub Btn.: %@",txtEmail.text);
	[request setPostValue:self.txtEmail.text forKey:@"email"];
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
		
		NSDictionary *results = [responseString JSONValue];
		
		//if([[results objectForKey:@"message"] isEqualToString:@"no such email"])
		if([[results objectForKey:@"message"] isEqualToString:@"check your mail"])
		{
		
			UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"" message:@"Successfully send to your mail ID" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			alert.tag=5;
			[alert show];
			[alert release];
		}
		else if ([[results objectForKey:@"message"] isEqualToString:@"email required"])
		{
	
		UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Entered wrong Email, please enter correct email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
		}
		else if ([[results objectForKey:@"message"] isEqualToString:@"no such email"])
		{
			UIAlertView *alert2= [[UIAlertView alloc]initWithTitle:@"" message:@"no such e-mail ID" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert2 show];
			[alert2 release];
		
		
		}

	}
}

- (IBAction) backClicked: (id) sender
{
	
	[self dismissModalViewControllerAnimated:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if(buttonIndex==0)
	{
	if(alertView.tag==5)
	{
		
		[self dismissModalViewControllerAnimated:YES];
		
		
	}
	}
	
	
	
	
}












/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	
	[txtEmail release];
	
    [super dealloc];
}


@end
