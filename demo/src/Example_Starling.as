package
{
	import ca.esdot.stats.FastStats;
	import ca.esdot.stats.FastStatsStarling;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Example_Starling extends flash.display.Sprite
	{
		public var example:*;
		
		protected var _starling:Starling;
		public static var starlingRoot:starling.display.Sprite;
		
		public function Example_Starling()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 100;
			stage.color = 0x0;
			
			setTimeout(init, 1);
			addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function init():void {
			_starling = new Starling(StarlingRoot, stage);
			_starling.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onStarlingReady);
			_starling.start();
		}
		
		protected function onStarlingReady(event:*):void {
			example = new DaisyFountain(stage, starlingRoot, DaisyFactory.getStarlingDaisy);
			//Add fast stats
			new FastStatsStarling(starlingRoot);
		}
		
		protected function onEnterFrame(event:*):void {
			if(!example){ return; }
			example.step()
			FastStats.numChildren = starlingRoot.numChildren;
		}
		
	}
}

import starling.display.Sprite;
class StarlingRoot extends Sprite {
	
	public function StarlingRoot() {
		Example_Starling.starlingRoot = this;
	}
	
}