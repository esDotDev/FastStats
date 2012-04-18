#Fast Stats

Fast Stats is designed for benchmarking GPU Accelerated Flash content with as little performance impact as possible.

![alt FastStats](https://github.com/esDotDev/FastStats/blob/master/screenshot/screen.png)

Unlike other Stats packages, which rely on displayList, TextFields and Graphic's API, FastStats uses cached bitmapData's to render everything.

FastStats currently supports the following rendering engine:

* Native DisplayList
* Starling
* ND2D

##Sample Usage

In it's most basic form you simply pass a reference to your root displayObjectContainer. This can be your stage, or any generic sprite:

	new FastStats(displayObjectContainer);

Starling is similar:

	new FastStatsStarling(starlingSprite)

ND2D as well:

	new FastStatsND2D(node2d);

If you would like to hide the background, that is optional:

	new FastStats(stage, false);

If you would like to position the stats somewhere other than the top, use a Sprite as your root:

	var s:Sprite = new Sprite();
	s.x = s.y = 200;
	addChild(s);
	new FastStats(s);

FastStats also supports the ability to display the total SpriteCount for a scene, but you must inject it manually from somewhere in your application:
	
	FastStats.numChildren = 120;


