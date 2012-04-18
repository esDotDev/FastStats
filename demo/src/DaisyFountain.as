package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.setTimeout;

	public class DaisyFountain
	{
		protected var _stage:Stage;
		protected var root:*;
		
		protected var daisyFactoryFunction:Function;
		
		public var daisyList:Array = [];
		
		public function DaisyFountain(stage:Stage, root:*, factoryFunction:Function){
			this.daisyFactoryFunction = factoryFunction;
			this._stage = stage;
			this.root = root;
			for(var i:int = 0; i < 500; i++){
				setTimeout(addDaisy, i * 10);
			}
		}
		
		public function step():void {
			for (var i:int=daisyList.length-1; i>0; i--) {
				var daisy:* = daisyList[i];
				daisy.vy += .35;
				daisy.vx *= 0.99;
				daisy.x += daisy.vx;
				daisy.y += daisy.vy;
				if(daisy.y > _stage.stageHeight){
					resetDaisy(daisy);
				}
			}
		}
		
		public function addDaisy():void {
			var daisy:* = daisyFactoryFunction();
			resetDaisy(daisy);
			daisyList.push(daisy);
			root.addChild(daisy);
		}
		
		protected function resetDaisy(daisy:*):void {
			// set up velocities:
			var a:Number = Math.PI/2*Math.random()-Math.PI*0.75;
			var v:Number = Math.random() * 20;
			
			daisy.vx = Math.cos(a)*v;
			daisy.vy = Math.min(-10 - 10 * Math.random(), Math.sin(a)*v);
			
			daisy.x = _stage.stageWidth/2 - daisy.width/2;
			daisy.y = _stage.stageHeight;
			
		}
	}
}