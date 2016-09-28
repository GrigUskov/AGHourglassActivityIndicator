# AGHourglassActivityIndicator
Old-school pixelated hourglass activity indicator component. Objective-C, no external images/resources used.

Usage:
<pre>
[self.view addSubview:({
	AGHourglassActivityIndicator *indicator = [[AGHourglassActivityIndicator alloc] init];
	indicator.color = [UIColor blackColor];  // optional, [UIColor grayColor] is default one
	indicator.animationDuration = 5;         // optional, 7 seconds by default
	[indicator startAnimating];
	indicator;
})];
</pre>
