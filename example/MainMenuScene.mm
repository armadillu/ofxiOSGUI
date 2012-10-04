//
//  MainMenuScene.cpp
//  Traffic
//
//  Created by Oriol Ferrer Mesià on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include <iostream>
#import "MainMenuScene.h"

MainMenuView * mainMenuGUI;

void MainMenuScene::setup(){

	printf("setup MainMenuScene\n");
	mainMenuGUI	= [[MainMenuView alloc] initWithNibName:@"MainMenuView" scene:this];
	ofxiOSGUI::instance()->addGUIView(mainMenuGUI.view);
	
};


void MainMenuScene::update(float){
	//your scene's update code here, if any
};


void MainMenuScene::draw(){
	//your scene's draw code here, if any
}


// Scene enter/exit Notifications //

void MainMenuScene::sceneWillAppear( ofxScene * fromScreen ){  // reset our scene when we appear
	printf("MainMenuScene WillAppear\n");
	//[mainMenuGUI fadeIn: 1.5];
	[mainMenuGUI show];
}

void MainMenuScene::sceneDidAppear(){  // reset our scene when we appear
	printf("MainMenuScene DidAppear\n");
}

void MainMenuScene::sceneWillDisappear( ofxScene * toScreen ){ 
	printf("MainMenuScene WillDisappear\n");
	//[mainMenuGUI fadeOut: 1.5];
	[mainMenuGUI hide];
}

void MainMenuScene::sceneDidDisappear( ofxScene * fromScreen ){
	printf("MainMenuScene DidDisappear\n");
}


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

@implementation MainMenuView

- (id)initWithNibName:(NSString *)nibName scene:(MainMenuScene *)scene{
	mainMenuScene = scene;
	return [super initWithNibName:nibName bundle:nil];
}


-(void)viewDidLoad { //this gets called when UI is loaded first time
	[self hide]; //start with hidden UI
}


/////////////////////////////////////////////////////////
// button callbacks /////////////////////////////////////
/////////////////////////////////////////////////////////

-(IBAction)button1:(id)sender;{
	if (mainMenuScene){
		//get access to next scene if you need to config it somehow special
		ofxScene * nextScene = ofxSceneManager::instance()->getScene(GAME1_SCENE);
		//jump to next scene
		ofxSceneManager::instance()->goToScene(GAME1_SCENE);
	}
}

-(IBAction)button2:(id)sender;{
	//launch your other scene here
}


-(IBAction)button3:(id)sender;{
	//launch your other scene here
}


@end
