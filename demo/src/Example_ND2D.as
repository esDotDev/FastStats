package
{
	import ca.esdot.stats.FastStats;
	import ca.esdot.stats.FastStatsND2D;
	
	import de.nulldesign.nd2d.display.Scene2D;
	import de.nulldesign.nd2d.display.World2D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class Example_ND2D extends Sprite
	{
		public var example:*;
		
		protected var world:World2D;
		protected var scene:Scene2D;
		
		public function Example_ND2D()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 100;
			stage.color = 0x0;
			
			setTimeout(init, 1);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			world = new World2D(Context3DRenderMode.AUTO, stage.frameRate);
			addChild(world);
			world.start();
			
			scene = new Scene2D();
			world.setActiveScene(scene);
		}
		
		protected function onEnterFrame(event:Event):void {
			if(!example){ return; }
			example.step()
			FastStats.numChildren = scene.numChildren;
		}
		
		protected function init():void {
			example = new DaisyFountain(stage, scene, DaisyFactory.getND2DDaisy);
			
			//Add fast stats
			new FastStatsND2D(scene);
		}
	}
}