//
//  ofxiOSGUI.cpp
//  SimpleGame
//
//  Created by Oriol Ferrer Mesià on 16/09/12.
//
//

#include "ofxiOSGUI.h"
#import "EAGLView+ForwardEvents.h"

ofxiOSGUI* ofxiOSGUI::singleton = NULL;

/////////////////////////////////////////////////////////////////////////////////
// Our addon  ///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////


ofxiOSGUI::ofxiOSGUI(){
	NSLog(@"w: %d, h: %d", ofGetWidth(), ofGetHeight());
	//UIView * guiHolder = [[UIView alloc] initWithFrame: CGRectInset( [[UIScreen mainScreen] bounds], 0, 0) ];
	UIView * guiHolder = [[UIView alloc] initWithFrame: CGRectMake(0, 0, ofGetWidth(), ofGetHeight()) ];
	guiHolder.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.0];
	guiHolder.opaque = FALSE;
	mainViewController = [[ofxiOSGUIController alloc] init];
	//mainViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	mainViewController.view = guiHolder;
	//NSLog(@"rect 1: %@", NSStringFromCGRect( [mainViewController.view frame] ) );

	//guiHolder.superview.autoresizesSubviews = YES;
	//guiHolder.autoresizesSubviews = YES;
	//[ofxiPhoneGetViewController().view insertSubview: mainViewController.view belowSubview: ofxiPhoneGetGLView()];

	//[ofxiPhoneGetUIWindow() setRootViewController: mainViewController]; //doing this after user sets a supported orientation to avoid unknonw answer to shouldAutorotateToInterfaceOrientation:

	//[UIViewController attemptRotationToDeviceOrientation];
	//[mainViewController.view setNeedsLayout];
}


void ofxiOSGUI::addGUIView( UIView * view /*, bool stretchToFitScreen */){

	//view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	//NSLog(@"rect b4 add: %@", NSStringFromCGRect( [mainViewController.view frame] ) );
	[mainViewController.view addSubview: view];

	//if (stretchToFitScreen){
		float retina = ofxiPhoneGetOFWindow()->isRetinaSupported() ? 0.5 : 1;
		[view setFrame: CGRectMake(0, 0, retina * ofGetWidth(), retina * ofGetHeight())];
		//[mainViewController.view setFrame: CGRectMake(0, 0, retina * ofGetWidth(), retina * ofGetHeight())];
	//}
	//NSLog(@"rect add: %@", NSStringFromCGRect( [mainViewController.view frame] ) );
	//[view setFrame: [mainViewController.view frame]];
	[UIViewController attemptRotationToDeviceOrientation];
	[mainViewController.view setNeedsLayout];
}


void ofxiOSGUI::addSupportedOrientation(UIInterfaceOrientation o){
	NSLog(@"addSupportedOrientation: %d", o);
	[mainViewController addSupportedOrientation:o];
	if (ofxiPhoneGetUIWindow().rootViewController == nil){
		[ofxiPhoneGetUIWindow() setRootViewController: mainViewController];
	}

	[UIViewController attemptRotationToDeviceOrientation];
	[mainViewController.view setNeedsLayout];
}


ofxiOSGUI* ofxiOSGUI::instance(){
	if (!singleton){   // Only allow one instance of class to be generated.
		singleton = new ofxiOSGUI();
	}
	return singleton;
}

UIViewController* ofxiOSGUI::getViewController(){
	return mainViewController;
}

/////////////////////////////////////////////////////////////////////////////////
// Our UIViewController Subclass ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

@implementation FadeableViewController

-(void)fadeIn:(float)duration{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	self.view.alpha = 1.0;
	[UIView commitAnimations];
}

-(void)fadeOut:(float)duration{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}

-(void)show;{
	self.view.alpha = 1.0;
}

-(void)hide;{
	self.view.alpha = 0.0;
}

@end

/////////////////////////////////////////////////////////////////////////////////
// Our GUI views holder controler Subclass //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

@implementation ofxiOSGUIController

- (void)addSupportedOrientation:(UIInterfaceOrientation)o{
	supportedOrientations.push_back(o);
	[UIViewController attemptRotationToDeviceOrientation];
}

//ios <= 5
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;{
	//NSLog(@"shouldAutorotateToInterfaceOrientation");
	if ( std::find(supportedOrientations.begin(),
				supportedOrientations.end(),
				toInterfaceOrientation) == supportedOrientations.end() )
	{
		return NO;
	}else{
		return YES;
	}
}


//ios >= 6
- (NSUInteger)supportedInterfaceOrientations{
	NSUInteger ret = 0;
	//printf("ios6 supportedInterfaceOrientations: ");
	for(int i = 0; i < supportedOrientations.size(); i++){
		switch (supportedOrientations[i]) {
			case UIInterfaceOrientationPortrait: /*printf("UIInterfaceOrientationPortrait, ");*/ ret |= UIInterfaceOrientationMaskPortrait; break;
			case UIInterfaceOrientationPortraitUpsideDown: /*printf("UIInterfaceOrientationPortraitUpsideDown, ");*/ ret |= UIInterfaceOrientationMaskPortraitUpsideDown; break;
			case UIInterfaceOrientationLandscapeLeft: /*printf("UIInterfaceOrientationLandscapeLeft, ");*/ ret |= UIInterfaceOrientationMaskLandscapeLeft; break;
			case UIInterfaceOrientationLandscapeRight: /*printf("UIInterfaceOrientationLandscapeRight, ");*/ ret |= UIInterfaceOrientationMaskLandscapeRight; break;
		}
	}
	//printf("\n");
	return ret;
}

- (BOOL)shouldAutorotate{
	//NSLog(@"shouldAutorotate");
	return YES;
}

//these 2 avoid the UI from showing an animated rotation when device is rotated (shows weird black frame)
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	[UIView setAnimationsEnabled:NO];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[UIView setAnimationsEnabled:YES];
}


/// USED TO FORWARD EVENTS TO OF WHEN GUI IS VISISBLE, WITH EAGLVIEW+FWEVENTS ///////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[ofxiPhoneGetGLView() touchesBegan: touches withEvent: event inView: self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[ofxiPhoneGetGLView() touchesMoved: touches withEvent: event inView: self.view];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[ofxiPhoneGetGLView() touchesEnded: touches withEvent: event inView: self.view];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[ofxiPhoneGetGLView() touchesCancelled: touches withEvent: event inView: self.view];
}

@end