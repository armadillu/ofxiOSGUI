#include "ofMain.h"
#include "testApp.h"

int main(){
	ofAppiPhoneWindow * iOSWindow = new ofAppiPhoneWindow();
	NSAutoreleasePool * p = [[NSAutoreleasePool alloc] init];
	
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
