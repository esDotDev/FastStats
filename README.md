#Fast Stats

Fast Stats is designed for benchmarking GPU Accelerated Flash content with as little performance impact as possible.

Unlike other Stats packages, which rely on displayList, TextFields and Graphic's API, FastStats uses cached bitmapData's to render everything.

FastStats currently supports the following rendering engine:

* Native DisplayList
* Starling
* ND2D

##Sample Usage

In it's most basic form you simply pass a reference to your root displayObjectContainer. This can be your stage, or any generic sprite:

	new FastStats(displayObjectContainer);

*For Starling and ND2D, use the equivalent class:*

	new FastStatsStarling(starlingSprite)
	new FastStatsND2D(node2d

If you would like to hide the background, that is optional:

	new FastStats(stage, false);

If you would like to position the stats somewhere other than the top, use a Sprite as your root:

	var s:Sprite = new Sprite();
	s.x = s.y = 200;
	new FastStats(s);

FastStats also supports the ability to display the total SpriteCount for a scene, but you must inject it manually from somewhere in your application:
	
	FastStats.numChildren = 120;


