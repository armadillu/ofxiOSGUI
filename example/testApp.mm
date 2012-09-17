#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// initialize the accelerometer
	ofxAccelerometer.setup();	
	//If you want a landscape oreintation 
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
	ofBackground(32,32,32);

	//setup iOS UI here by specifying your app's supported UI orientations
	ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationLandscapeRight);
	//ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationLandscapeLeft);

	sceneManager = ofxSceneManager::instance();
	sceneManager->addScene( new MainMenuScene(), MAIN_MENU_SCENE);
	sceneManager->addScene( new GameplayScene(), GAME1_SCENE);
		
	sceneManager->setDrawDebug(false);
	sceneManager->setCurtainDropTime(CURTAIN_DROP_TIME);
	sceneManager->setCurtainStayTime(0.0);
	sceneManager->setCurtainRiseTime(CURTAIN_RISE_TIME);
	sceneManager->setOverlapUpdate(false);
	
	sceneManager->goToScene(MAIN_MENU_SCENE, true /*regardless*/, false /*transition*/);

}


void testApp::update(){
	
	TIME_SAMPLE_START("update");
	float dt = 0.016666666;
	sceneManager->update( dt );
	TIME_SAMPLE_STOP("update");
}


void testApp::draw(){
	
	TIME_SAMPLE_START("draw");
	sceneManager->draw();
	TIME_SAMPLE_STOP("draw");
	
	glColor4ub(255,255,255,255);
	TIME_SAMPLE_DRAW_BOTTOM_LEFT();
}


void testApp::touchDown(ofTouchEventArgs &touch){
	sceneManager->touchDown(touch);
}

void testApp::touchMoved(ofTouchEventArgs &touch){
	sceneManager->touchMoved(touch);
}

void testApp::touchUp(ofTouchEventArgs &touch){
	sceneManager->touchUp(touch);
}

void testApp::touchDoubleTap(ofTouchEventArgs &touch){	
	sceneManager->touchDoubleTap(touch);
}


void testApp::exit(){}
