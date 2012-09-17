/*
 *  SimpleGame.h
 *  emptyExample
 *
 *  Created by Oriol Ferrer Mesià on 07/06/12.
 *  Copyright 2012 uri.cat. All rights reserved.
 *
 */

#pragma once

#include "globals.h"
#include "ofMain.h"
#include "ofxSceneManager.h"

class SimpleGame{

public:
		
		void setup();
		
		void draw();
		void update(float dt);
		
		void touchDown(ofTouchEventArgs &touch);
		void touchUp(ofTouchEventArgs &touch);
		void touchMoved(ofTouchEventArgs &touch);
		void touchDoubleTap(ofTouchEventArgs &touch);

	
		void pause();
		void resume();

	private:

		ofVec2f pos;
		float time;

};
