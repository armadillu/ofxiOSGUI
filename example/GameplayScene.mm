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
	gameGui	= [[GameView alloc] initWithNibName:@"GameView" scene:this];
	ofxiOSGUI::instance()->addGUIView(gameGui.view);

	game = new SimpleGame();
	game->setup();
}


void GameplayScene::update(float dt){		
	game->update(dt);		
}

void GameplayScene::draw(){		
	game->draw();		
}

void GameplayScene::showUI(){
	[gameGui show];
}

void GameplayScene::hideUI(){
	[gameGui hide];
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

void GameplayScene::sceneWillAppear( ofxScene * fromScreen ){  // reset our scene when we appear
	printf("GameplayScene WillAppear\n");
	game->resume();
}

void GameplayScene::sceneDidAppear(){  // reset our scene when we appear
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


-(IBAction)resume:(id)sender;{
	if (gameScene){
		printf("resume gameScene\n");
		gameScene->resumeScene();
		[self hide];
	}
}


-(IBAction)exit:(id)sender;{
	if (gameScene){
		printf("exit gameScene\n");
		ofxSceneManager::instance()->goToScene(MAIN_MENU_SCENE);
		[self hide];
	}
}

@end
