#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxSceneManager.h"
#include "GameplayScene.h"
#include "MainMenuScene.h"
#include "ofxiOSGUI.h"
#include "globals.h"


enum Scenes{ MAIN_MENU_SCENE = 0, GAME1_SCENE  };


class testApp : public ofxiPhoneApp{
	
    public:
        void setup();
        void update();
        void draw();
		void exit(){};

        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
		void touchCancelled(ofTouchEventArgs & touch){};

		void lostFocus(){};
		void gotFocus(){};
		void gotMemoryWarning(){};
		void deviceOrientationChanged(int newOrientation){};
	
		ofxSceneManager *		sceneManager;

};


