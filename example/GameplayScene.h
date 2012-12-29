//
//  GameplayScene.h
//  Traffic
//
//  Created by Oriol Ferrer Mesià on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef _GameplayScene_h
#define _GameplayScene_h


#include "ofMain.h"
#include "ofxSceneManager.h"
#include "ofxiPhone.h"
#include "testApp.h"
#include "SimpleGame.h"
#include "ofxiOSGUI.h"

class GameplayScene : public ofxScene{

public:
	
	void setup();
	void update(float dt);
	void draw();

	void showUI();
	void hideUI();

	void pauseScene();
	void resumeScene();

	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);

	// scene notifications /////////////////////////////////////////////////////////
	
	void sceneWillAppear( ofxScene * fromScreen );
	void sceneDidAppear();
	void sceneWillDisappear( ofxScene * toScreen );
	void sceneDidDisappear( ofxScene * fromScreen );
	
	SimpleGame * game;	
};


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>
#include "GameplayScene.h"
#include "globals.h"
#include "ofxiOSGUI.h"


@interface GameView : FadeableViewController {
	GameplayScene *gameScene;
}

-(id)initWithNibName:(NSString *)nibName scene:(GameplayScene *)scene;
-(void)viewDidLoad;

-(IBAction)resume:(id)sender; //our iOS UI buttons action
-(IBAction)exit:(id)sender; //our iOS UI buttons action

@end

#endif
