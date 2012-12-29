//
//  GameplayScene.mm
//  Traffic
//
//  Created by Oriol Ferrer Mesià on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include <iostream>
#include "GameplayScene.h"

GameView * gameGui;


void GameplayScene::setup(){

	printf("setup GameplayScene\n");
	gameGui	= [[GameView alloc] initWithNibName:@"GameView" scene:this]; //load nib UI for our gameplay scene
	ofxiOSGUI::instance()->addGUIView(gameGui.view); //add our GameView UI view to ofxiOSGUI

	game = new SimpleGame();
	game->setup();
}


void GameplayScene::update(float dt){		
	game->update(dt);	//forward the update call to our actual OF game
}

void GameplayScene::draw(){		
	game->draw();		//forward the draw call to our actual OF game
}

void GameplayScene::showUI(){
	[gameGui show]; //make the UI for this scene show
}

void GameplayScene::hideUI(){
	[gameGui hide]; //make the UI for this scene hide
}


void GameplayScene::pauseScene(){
	game->pause();
}

void GameplayScene::resumeScene(){
	game->resume();
}


// scene events /////////////////////////////////////////////////////////

void GameplayScene::touchDown(ofTouchEventArgs &touch){
	game->touchDown(touch);	
}

void GameplayScene::touchMoved(ofTouchEventArgs &touch){
	game->touchMoved(touch);
}

void GameplayScene::touchUp(ofTouchEventArgs &touch){
	game->touchUp(touch);
}

void GameplayScene::touchDoubleTap(ofTouchEventArgs &touch){
	game->touchDoubleTap(touch);
}

// Scene enter/exit Notifications ///////////////////////////////////////

void GameplayScene::sceneWillAppear( ofxScene * fromScreen ){ 
	printf("GameplayScene WillAppear\n");
	game->resume();
}

void GameplayScene::sceneDidAppear(){
	printf("GameplayScene DidAppear\n");
}

void GameplayScene::sceneWillDisappear( ofxScene * toScreen ){ 
	printf("GameplayScene WillDisappear\n");
}

void GameplayScene::sceneDidDisappear( ofxScene * fromScreen ){
	printf("GameplayScene DidDisappear\n");
	game->pause();
}


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


@implementation GameView

- (id)initWithNibName:(NSString *)nibName scene:(GameplayScene *)scene{
	gameScene = scene;
	return [super initWithNibName:nibName bundle:nil];
}


-(void)viewDidLoad { //this gets called when UI is loaded first time
	[self hide]; //start with hidden UI
}


/////////////////////////////////////////////////////////
// button callbacks /////////////////////////////////////
/////////////////////////////////////////////////////////


-(IBAction)resume:(id)sender;{ //our iOS UI buttons action
	if (gameScene){
		printf("resume gameScene\n");
		//once the "resume" button is clicked, resume game, hide the UI
		gameScene->resumeScene();
		[self hide];
	}
}


-(IBAction)exit:(id)sender;{ //our iOS UI buttons action
	if (gameScene){
		printf("exit gameScene\n");
		//once the "exit" button is clicked, jump to main scene, hide the UI
		ofxSceneManager::instance()->goToScene(MAIN_MENU_SCENE);
		[self hide];
	}
}

@end
