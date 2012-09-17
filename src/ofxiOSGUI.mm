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
	float retina = ofxiPhoneGetOFWindow()->isRetinaSupported() ? 0.5 : 1;
	CGRect frame = CGRectMake(0, 0, retina * ofGetWidth(), retina * ofGetHeight());
	UIView * guiHolder = [[UIView alloc] initWithFrame:frame];
	guiHolder.backgroundColor = [UIColor clearColor];
	mainViewController = [[ofxiOSGUIController alloc] init];
	mainViewController.view = guiHolder;
	[guiHolder setFrame: CGRectMake(0, 0, retina * ofGetWidth(), retina * ofGetHeight())];
	[ofxiPhoneGetUIWindow() addSubview: mainViewController.view];
}


void ofxiOSGUI::addGUIView( UIView * view, bool stretchToFitScreen ){

	[mainViewController.view addSubview: view];
	if (stretchToFitScreen){
		float retina = ofxiPhoneGetOFWindow()->isRetinaSupported() ? 0.5 : 1;
		[view setFrame: CGRectMake(0, 0, retina * ofGetWidth(), retina * ofGetHeight())];
	}
}


void ofxiOSGUI::addSupportedOrientation(UIInterfaceOrientation o){
	[mainViewController addSupportedOrientation:o];
}


ofxiOSGUI* ofxiOSGUI::instance(){
	if (!singleton){   // Only allow one instance of class to be generated.
		singleton = new ofxiOSGUI();
	}
	return singleton;
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;{
	NSLog(@"shouldAutoRotate");
	if ( std::find(supportedOrientations.begin(),
				supportedOrientations.end(),
				toInterfaceOrientation) == supportedOrientations.end() )
	{
		return NO;
	}else{
		return YES;
	}
}

//these 2 avoid the UI animating an animated rotation when device is rotated
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
	[UIView setAnimationsEnabled:NO];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[UIView setAnimationsEnabled:YES];
}


/////////////	THIS IS THE MAGICAL BIT  ////////////////////////////////////////////
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