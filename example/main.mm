#include "ofMain.h"
#include "testApp.h"

int main(){

	NSAutoreleasePool * p = [[NSAutoreleasePool alloc] init];
	ofAppiPhoneWindow * iOSWindow = new ofAppiPhoneWindow();

	//iOSWindow->enableDepthBuffer();
	//iOSWindow->enableAntiAliasing(4);
	if ( [[UIScreen mainScreen] scale] > 1 ){
		iOSWindow->enableRetinaSupport();
	}
	
	[p release];
	
	ofSetupOpenGL(iOSWindow, 480, 320, OF_FULLSCREEN);
	testApp * app = new testApp();
	ofRunApp( app );
}
