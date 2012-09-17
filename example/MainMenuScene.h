//
//  MainMenuScene.h
//  emptyExample
//
//  Created by Oriol Ferrer Mesià on 11/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MainMenuScene_h
#define MainMenuScene_h

#include "ofMain.h"
#include "ofxScene.h"
#include "ofxiPhone.h"
#include "testApp.h"
#include "ofxiOSGUI.h"

class MainMenuScene : public ofxScene{

public:
	
	void setup();
	void update(float);		
	void draw();

	// scene notifications /////////////////////////////////////////////////////////
	void sceneWillAppear( ofxScene * fromScreen );
	void sceneDidAppear();
	void sceneWillDisappear( ofxScene * toScreen );
	void sceneDidDisappear( ofxScene * fromScreen );

};


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>
#include "testApp.h"
#include "MainMenuScene.h"
#include "globals.h"


@interface MainMenuView : FadeableViewController {
	MainMenuScene *mainMenuScene;
}

-(id)initWithNibName:(NSString *)nibName scene:(MainMenuScene *)scene;
-(void)viewDidLoad;


-(IBAction)button1:(id)sender;
-(IBAction)button2:(id)sender;
-(IBAction)button3:(id)sender;

@end


#endif
