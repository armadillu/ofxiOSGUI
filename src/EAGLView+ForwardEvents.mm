#import "EAGLView.h"
#import "ofxiPhoneExtras.h"

@implementation EAGLView (ForwardEvents)

/******************* TOUCH EVENTS ********************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view{
	
	for(UITouch *touch in touches) {
		int touchIndex = 0;
		while([[activeTouches allValues] containsObject:[NSNumber numberWithInt:touchIndex]]) {
			touchIndex++;
		}
		
		[activeTouches setObject:[NSNumber numberWithInt:touchIndex] forKey:[NSValue valueWithPointer:touch]];
		
		CGPoint touchPoint = [touch locationInView:view];
		
		touchPoint.x*=touchScaleFactor; // this has to be done because retina still returns points in 320x240 but with high percision
		touchPoint.y*=touchScaleFactor;

		//iPhoneGetOFWindow()->rotateXY(touchPoint.x, touchPoint.y);

		//if( touchIndex==0 ){ //uri
			ofNotifyMousePressed(touchPoint.x, touchPoint.y, 0);
		//}
		
		ofTouchEventArgs touchArgs;
		touchArgs.x = touchPoint.x;
		touchArgs.y = touchPoint.y;
		touchArgs.id = touchIndex;
		if([touch tapCount] == 2) ofNotifyEvent(ofEvents().touchDoubleTap,touchArgs);	// send doubletap
		ofNotifyEvent(ofEvents().touchDown,touchArgs);	// but also send tap (upto app programmer to ignore this if doubletap came that frame)
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view{
		//NSLog(@"touchesMoved: %i %i ", [touches count],  [[event touchesForView:view] count]);
	
	for(UITouch *touch in touches) {
		int touchIndex = [[activeTouches objectForKey:[NSValue valueWithPointer:touch]] intValue];
		//		[activeTouches setObject:[NSNumber numberWithInt:touchIndex] forKey:[NSValue valueWithPointer:touch]];
		
		CGPoint touchPoint = [touch locationInView:view];
		
		touchPoint.x*=touchScaleFactor; // this has to be done because retina still returns points in 320x240 but with high percision
		touchPoint.y*=touchScaleFactor;

		//iPhoneGetOFWindow()->rotateXY(touchPoint.x, touchPoint.y);
		
		//if( touchIndex==0 ){ //uri
			ofNotifyMouseDragged(touchPoint.x, touchPoint.y, 0);			
		//}		
		ofTouchEventArgs touchArgs;
		touchArgs.numTouches = [[event touchesForView:view] count];
		touchArgs.x = touchPoint.x;
		touchArgs.y = touchPoint.y;
		touchArgs.id = touchIndex;
		ofNotifyEvent(ofEvents().touchMoved, touchArgs);
	}
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view{
	//	NSLog(@"touchesEnded: %i %i %i", [touches count],  [[event touchesForView:self] count], multitouchData.numTouches);
	for(UITouch *touch in touches) {
		int touchIndex = [[activeTouches objectForKey:[NSValue valueWithPointer:touch]] intValue];
		
		[activeTouches removeObjectForKey:[NSValue valueWithPointer:touch]];
		
		CGPoint touchPoint = [touch locationInView: view];
		
		touchPoint.x*=touchScaleFactor; // this has to be done because retina still returns points in 320x240 but with high percision
		touchPoint.y*=touchScaleFactor;

		//iPhoneGetOFWindow()->rotateXY(touchPoint.x, touchPoint.y);
		
		//if( touchIndex==0 ){ //uri
			ofNotifyMouseReleased(touchPoint.x, touchPoint.y, 0);						
		//}
		
		ofTouchEventArgs touchArgs;
		touchArgs.numTouches = [[event touchesForView:view] count] - [touches count];
		touchArgs.x = touchPoint.x;
		touchArgs.y = touchPoint.y;
		touchArgs.id = touchIndex;
		ofNotifyEvent(ofEvents().touchUp, touchArgs);
	}
}

//------------------------------------------------------
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event inView:(UIView*) view{
	
	
	for(UITouch *touch in touches) {
		int touchIndex = [[activeTouches objectForKey:[NSValue valueWithPointer:touch]] intValue];
		
		CGPoint touchPoint = [touch locationInView:view];
		
		touchPoint.x*=touchScaleFactor; // this has to be done because retina still returns points in 320x240 but with high percision
		touchPoint.y*=touchScaleFactor;

		ofTouchEventArgs touchArgs;
		touchArgs.numTouches = [[event touchesForView:view] count];
		touchArgs.x = touchPoint.x;
		touchArgs.y = touchPoint.y;
		touchArgs.id = touchIndex;
		ofNotifyEvent(ofEvents().touchCancelled, touchArgs);
	}
	
	[self touchesEnded:touches withEvent:event];
}


@end
