Basic OF setup for a multi-scene (each with its own native UI) iOS app/game, with basic transitions between scenes. 

It also ofers multi-orientation native UI support. Keep in mind that only the UI will rotate with the device; the UI is not attached to the actual OpenGL view. You will need to re-arrange your OF drawing code if you want it to match the orientation of UI and the device.

See example video [here](http://www.youtube.com/watch?v=ozXEsObqomM).

The Multiple orientation feature is quite unusable; should work on OF0071.

OF0072 and OF0073 added big changes to how the main UIView of the iOS app is setup, and I still haven't been able to make the horizontal orientations work. It will behave differently than in OF0071, as the OF contents will be rotated with the UI. It should be fine for portrait only apps though.

Orientation feature is also largely untested in different iOS versions, and I've been getting different results in simulator / device; but should be fine if used with OF0071.

Just a quick note; make sure the app's specified supported orientations in Xcode(on your info.plist) matches the orientations specified in your code:

	ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationPortrait);
	ofxiOSGUI::instance()->addSupportedOrientation(UIInterfaceOrientationPortraitUpsideDown);

![demo image](http://farm9.staticflickr.com/8361/8320120970_b6bf430eee.jpg)

Otherwise you might get a crash and a message similar to this on Xcode on OF0073:

	*** Terminating app due to uncaught exception 'UIApplicationInvalidInterfaceOrientation', reason: 'Supported orientations has no common orientation with the application, and shouldAutorotate is returning YES'