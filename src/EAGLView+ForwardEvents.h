
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ESRenderer.h"
#import "EAGLView.h"
#include "ofxiPhone.h"
#import "ofxiPhoneExtras.h"


@interface ofxiOSEAGLView (ForwardEvents)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view;
@end
