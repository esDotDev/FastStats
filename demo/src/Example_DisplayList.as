package
{
	import ca.esdot.stats.FastStats;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class Example_DisplayList extends Sprite
	{
		public var example:*;
		
		public function Example_DisplayList()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 100;
			stage.color = 0x0;
			
			setTimeout(init, 1);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void {
			if(!example){ return; }
			example.step()
				
			FastStats.numChildren = stage.numChildren;
		}
		
		protected function init():void {
			example = new DaisyFountain(stage, stage, DaisyFactory.getDaisy);
			new FastStats(this);
		}
	}
}