package ca.esdot.stats
{
	import flash.display.BitmapData;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class FastStatsStarling extends FastStats
	{
		protected var starlingRoot:Sprite;
		
		public function FastStatsStarling(root:Sprite, showBg:Boolean=true){
			starlingRoot = root;
			super(null, showBg);
		}
		
		override protected function init():void {
			_root = starlingRoot;
			if(starlingRoot.stage){
				_stage = starlingRoot.stage;
				onAddedToStage();
			} else {
				starlingRoot.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}
		
		override protected function renderBg(cache:BitmapData):void {
			if(!bg){
				bg = new Image(Texture.fromBitmapData(cache));
				if(showBg){
					_root.addChild(bg);
				}
			}
			(bg as Image).texture = Texture.fromBitmapData(cache)
		}
		
		override protected function renderStats(cache:BitmapData):void {
			if(!statsCache){
				statsCache = new Image(Texture.fromBitmapData(cache));
				_root.addChild(statsCache);
			}
			(statsCache as Image).texture = Texture.fromBitmapData(cache);
		}
	}
}