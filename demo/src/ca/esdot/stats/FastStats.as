package ca.esdot.stats
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	public class FastStats extends Object {
		
		protected var _stage:Object;
		protected var _root:Object;
		
		protected var smallFontSize:int = 16;
		protected var largeFontSize:int = 28;
		protected var statsHeight:int = 50;
		
		public static var numChildren:int = 0;
		
		protected var lastUpdateTime:int = 0;
		protected var numTicks:int = 0;
		protected static var _fps:Number;
		
		protected var numbers:Array = [];
		protected var hzStack:Array = [];
		
		//Display Children
		protected var bg:*;
		protected var statsCache:*;
		
		protected var fpsLabel:TextField;
		protected var spritesLabel:TextField;
		protected var memoryLabel:TextField;
		protected var children:Sprite;
		protected var fpsText:TextField;
		protected var spritesText:TextField;
		protected var memoryText:TextField;
		
		protected var showBg:Boolean;
		
		public function FastStats(root:DisplayObjectContainer, showBg:Boolean = true) {
			this.showBg = showBg;
			_root = root; 
			init();
		}
		
		protected function init():void {
			var root:DisplayObjectContainer = _root as DisplayObjectContainer;
			if(root.stage || root is Stage){
				_stage = (root is Stage)? root : root.stage;
				onAddedToStage();
			} else {
				root.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			}
		}
		
		public static function get fps():int{ return _fps; }
		
		public function set visible(value:Boolean):void {
			bg.visible = value;
			statsCache.visible = value;
		}

		protected function createChildren():void {
			if(children){ return; }
			//Add just a little style to the bg... why not :)
			var bgData:BitmapData = new BitmapData(2, statsHeight, false, 0x3a3a3a);
			bgData.setPixel(0, statsHeight-1, 0x535353); bgData.setPixel(1, statsHeight-1, 0x535353);
			bgData.setPixel(0, statsHeight-2, 0x282828); bgData.setPixel(1, statsHeight-2, 0x282828);
			bgData.setPixel(0, statsHeight-3, 0x535353); bgData.setPixel(1, statsHeight-3, 0x535353);
			bgData.setPixel(0, 0, 0x535353); bgData.setPixel(1, 0, 0x535353);
			bgData.setPixel(0, 1, 0x282828); bgData.setPixel(1, 1, 0x282828);
			bgData.setPixel(0, 2, 0x535353); bgData.setPixel(1, 2, 0x282828);
			renderBg(bgData);
			
			children = new Sprite();
			var tf:TextFormat = new TextFormat("Arial", smallFontSize, 0xFFFFFF);
			//_stage.addChild(children);
			
			//Labels
			fpsLabel = getTextField(tf);
			fpsLabel.text = "FPS:";
			children.addChild(fpsLabel);
			
			spritesLabel = getTextField(tf);
			spritesLabel.text = "SPRITE COUNT:";
			children.addChild(spritesLabel);
			
			memoryLabel = getTextField(tf);
			memoryLabel.text = "MEMORY:";
			children.addChild(memoryLabel);
			
			tf.size = largeFontSize;
			tf.bold = true;
			
			//VALUES
			fpsText = getTextField(tf);
			fpsText.text = "--";
			children.addChild(fpsText);
			
			spritesText = getTextField(tf);
			spritesText.text = "--";
			children.addChild(spritesText);
			
			memoryText = getTextField(tf);
			memoryText.text = "--";
			children.addChild(memoryText);
			
			//Define hz zstacking order
			hzStack = [
				fpsLabel, fpsText,
				spritesLabel, spritesText,
				memoryLabel, memoryText
			]
		}
		
		/**
		 * Override this to support different render targets
		 **/
		protected function renderBg(cache:BitmapData):void {
			if(!bg){
				bg = new Bitmap();
				if(showBg){
					_root.addChild(bg);
				}
			}
			bg.bitmapData = cache;
		}
		
		/**
		 * Override this to support different render targets
		 **/
		protected function renderStats(cache:BitmapData):void {
			if(!statsCache){
				statsCache = new Bitmap();
				_root.addChild(statsCache);
			}
			statsCache.bitmapData = cache;
			setSize(bg.width, bg.height);
		}
		
		
		public function setSize(width:int, heightL:int):void {
			bg.width = width;
			if(statsCache){
				statsCache.y = bg.height - statsCache.height >> 1;
				statsCache.x = 30;
			}	
		}
		
		
		public function updateStats():void {
			fpsText.text = fps.toString();
			spritesText.text = FastStats.numChildren.toString();
			memoryText.text = Number((System.totalMemory * 0.000000954).toFixed(3)) + "mb";
			
			var xOffset:int = 0;
			for(var i:int = 0, l:int = hzStack.length; i < l; i++){
				hzStack[i].x = xOffset;
				xOffset += hzStack[i].textWidth + 5; 
				if((i+1)%2 == 0){ 
					xOffset += 20; 
				} else {
					hzStack[i].y = largeFontSize - smallFontSize - 2;
				}
			}
			
			var cache:BitmapData = new BitmapData(children.width, children.height, true, 0x0);
			cache.draw(children);
			
			renderStats(cache);
		}
		
		
		protected function onAddedToStage(event:* = null):void {
			_stage = _root.stage;
			//Use a strong listener to make sure we're never GC'd
			_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stage.addEventListener(Event.RESIZE, onStageResize);
			
			createChildren();
			onStageResize();
		}
		
		protected function onEnterFrame(event:*):void {
			numTicks++;
			if(getTimer() - lastUpdateTime > 1500){
				_fps = Math.round(numTicks / ((getTimer() - lastUpdateTime)/1000));
				lastUpdateTime = getTimer();
				updateStats();
				numTicks = 0;
			}
		}
		
		protected function onStageResize(event:* = null):void {
			setSize(_stage.stageWidth, _stage.stageHeight);
		}
		
		protected function getTextField(format:TextFormat):TextField {
			var tf:TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.height = largeFontSize;
			tf.width = 100;
			tf.autoSize = TextFieldAutoSize.LEFT;
			return tf;
		}
		
	}
}