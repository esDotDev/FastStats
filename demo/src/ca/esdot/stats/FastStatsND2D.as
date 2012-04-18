package ca.esdot.stats
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class FastStatsND2D extends FastStats
	{
		protected var nd2dRoot:Node2D;
		
		public function FastStatsND2D(root:Node2D, interval:int = 1000, showBg:Boolean = true, isVisible:Boolean = true) {
			nd2dRoot = root;
			super(null, interval, showBg, isVisible);
		}
		
		override protected function init():void {
			_root = nd2dRoot;
			if(nd2dRoot.stage){
				_stage = nd2dRoot.stage;
				onAddedToStage();
			} else {
				nd2dRoot.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			}
		}
		
		override protected function renderBg(cache:BitmapData):void {
			if(!bg){
				bg = new Sprite2D(Texture2D.textureFromBitmapData(cache));
				bg.pivot = new Point(-bg.width/2, -bg.height/2);
				if(showBg){
					_root.addChild(bg);
				}
			}
			(bg as Sprite2D).setTexture(Texture2D.textureFromBitmapData(cache));
		}
		
		override protected function renderStats(cache:BitmapData):void {
			if(!statsCache){
				statsCache = new Sprite2D(Texture2D.textureFromBitmapData(cache));
				_root.addChild(statsCache);
			}
			(statsCache as Sprite2D).setTexture(Texture2D.textureFromBitmapData(cache));
			setSize(bg.width, bg.height);
		}
		
		override public function setSize(width:int, height:int):void {
			if(statsCache){
				statsCache.pivot = new Point(-statsCache.width/2, -statsCache.height/2);
			}
			super.setSize(width, height);
		}
		
		
	}
}