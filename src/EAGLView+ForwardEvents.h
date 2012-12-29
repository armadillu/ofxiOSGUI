
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ESRenderer.h"
#import "EAGLView.h"
#include "ofxiPhone.h"
#import "ofxiPhoneExtras.h"

#if ( OF_VERSION == 6 ) // OF pre007 no bueno
	#error This Addon requires at least OF_007
#endif

#if ( OF_VERSION == 7 ) && (OF_VERSION_MINOR == 1) //OF_0071
	#define OFXIOSGUI_IOS_VIEW_CLASS EAGLView
	#define OFXIOSGUI_SCALE_FACTOR touchScaleFactor
#else // OF_0072, OF_0073 and hopefully the future
	#define OFXIOSGUI_IOS_VIEW_CLASS ofxiOSEAGLView
	#define OFXIOSGUI_SCALE_FACTOR scaleFactor
#endif


@interface OFXIOSGUI_IOS_VIEW_CLASS (ForwardEvents)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
@end
