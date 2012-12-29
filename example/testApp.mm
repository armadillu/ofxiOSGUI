#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	


	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_LEFT);
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_PORTRAIT); // for this example, OF View will always be portrait
	ofBackground(32,32,32);

	//setup iOS GUI here by specifying your app's supported UI orientations
	ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationPortrait);
	ofxiOSGUI::instance()->addSupportedOrientation(UIDeviceOrientationPortraitUpsideDown);
	//ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationLandscapeRight); //OF and iOS have inverted LEFT / RIGHT orientations?
	//ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationLandscapeLeft);

	sceneManager = ofxSceneManager::instance(); // store a ptr to the ofxSceneManager's instance for quick access

	//add scenes to app, in out case 2
	sceneManager->addScene( new MainMenuScene(), MAIN_MENU_SCENE);
	sceneManager->addScene( new GameplayScene(), GAME1_SCENE);
		
	sceneManager->setDrawDebug(true); //show transition and scene manager info

	//define the between-scenes transition speeds
	sceneManager->setCurtainDropTime(CURTAIN_DROP_TIME); //define fade out duration
	sceneManager->setCurtainStayTime(0.0); //define stay faded duration
	sceneManager->setCurtainRiseTime(CURTAIN_RISE_TIME); //define fade in duration

	sceneManager->setOverlapUpdate(false); //if true, both in and out scenes get update() called while transitioning between scenes

	//define which scene we start from
	sceneManager->goToScene(MAIN_MENU_SCENE, true /*regardless*/, false /*transition*/);

}


void testApp::update(){
	
	float dt = 1./60.;
	sceneManager->update( dt ); //this will handle the updating of all your scenes when required
}


void testApp::draw(){
	
	sceneManager->draw(); //this will handle the drawing of all your scenes when required
}


void testApp::touchDown(ofTouchEventArgs &touch){
	sceneManager->touchDown(touch); //fw our touch events to the scene manager for it to fw to the appropriate scene
}

void testApp::touchMoved(ofTouchEventArgs &touch){
	sceneManager->touchMoved(touch); //fw our touch events to the scene manager for it to fw to the appropriate scene
}

void testApp::touchUp(ofTouchEventArgs &touch){
	sceneManager->touchUp(touch); //fw our touch events to the scene manager for it to fw to the appropriate scene
}

void testApp::touchDoubleTap(ofTouchEventArgs &touch){	
	sceneManager->touchDoubleTap(touch); //fw our touch events to the scene manager for it to fw to the appropriate scene
}

