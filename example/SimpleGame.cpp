/*
 *  SimpleGame.cpp
 *  emptyExample
 *
 *  Created by Oriol Ferrer Mesià on 07/06/12.
 *  Copyright 2012 uri.cat. All rights reserved.
 *
 */

#include <iostream>
#include "SimpleGame.h"

void SimpleGame::setup(){

	time = 0;
	gamePaused = false;
}

void SimpleGame::pause(){
	gamePaused = true;
}


void SimpleGame::resume(){	
	gamePaused = false;
}


void SimpleGame::update(float dt){
	
	if (!gamePaused){
		time += dt;
		pos.x = ofGetWidth() * 0.2 * cosf( 2 * time );
		pos.y = ofGetWidth() * 0.2 * sinf( 2 * time );
	}
}


void SimpleGame::draw(){
	ofSetColor(255);
	ofCircle(
			 ofGetWidth() * 0.5f + pos.x,
			 ofGetHeight() * 0.5f + pos.y,
			 20
			 );

	ofDrawBitmapString("2-tap to pause", ofGetWidth()/2, ofGetHeight()/2);
}


void SimpleGame::touchDown(ofTouchEventArgs &touch){
}


void SimpleGame::touchMoved(ofTouchEventArgs &touch){
}


void SimpleGame::touchUp(ofTouchEventArgs &touch){
}

void SimpleGame::touchDoubleTap(ofTouchEventArgs &touch){
	//reach the CURRENT SCENE and pause it, then show UI
	ofxSceneManager::instance()->getCurrentScene()->pauseScene();
	ofxSceneManager::instance()->getCurrentScene()->showUI();
}

