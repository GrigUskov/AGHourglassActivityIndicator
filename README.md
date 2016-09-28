# AGHourglassActivityIndicator
Old-school pixelated hourglass activity indicator component for iOS. Objective-C, no external images/resources used.

<img src="http://alsedi.com/github/AGHourglassActivityIndicator.gif">

Two styles available (see style property):

<img src="http://alsedi.com/github/AGHourglassActivityIndicator_styles.png">

Usage:
<pre>
[self.view addSubview:({
	AGHourglassActivityIndicator *indicator = [[AGHourglassActivityIndicator alloc] init]; // or initWithStyle, Frame etc...
	indicator.color = [UIColor blackColor];  // optional, [UIColor grayColor] is default one
	indicator.animationDuration = 5;         // optional, 7 seconds by default
	[indicator startAnimating];
	indicator;
})];
</pre>
