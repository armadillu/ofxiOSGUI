//
//  ofxiOSGUI.h
//  SimpleGame
//
//  Created by Oriol Ferrer Mesià on 16/09/12.
//
//

#ifndef _ofxiOSGUI_h
#define _ofxiOSGUI_h

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#import <UIKit/UIKit.h>


/////////////////////////////////////////////////////////////////////////////////
// Our UIViewController Subclass ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////


@interface FadeableViewController : UIViewController {}

-(void)fadeIn:(float)duration; //show with fade transition
-(void)fadeOut:(float)duration;

-(void)show; //show with no animation
-(void)hide;

@end

/////////////////////////////////////////////////////////////////////////////////
// Our GUI views holder controler Subclass //////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////


@interface ofxiOSGUIController : FadeableViewController {
	vector<int> supportedOrientations;
}

- (void)addSupportedOrientation:(UIInterfaceOrientation)o;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
- (BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;

@end


/////////////////////////////////////////////////////////////////////////////////
// Our addon  ///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////


class ofxiOSGUI{

	public:

		static ofxiOSGUI* instance();
		void addSupportedOrientation(UIInterfaceOrientation);
		void addGUIView( UIView * view /*, bool stretchToFitScreen = false */);
		UIViewController * getViewController();

	private:

		ofxiOSGUI(); //use instance() instead!
		static ofxiOSGUI* singleton;
		ofxiOSGUIController * mainViewController;
};


#endif
