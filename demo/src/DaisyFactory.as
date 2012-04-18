package
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	import starling.display.Image;
	import starling.textures.Texture;

	public class DaisyFactory
	{
		[Embed(source="assets/daisy.png")]
		protected static var Daisy:Class;
		protected static var daisyData:BitmapData = new Daisy().bitmapData;
		
		protected static var nd2dTexture:Texture2D;
		protected static var starlingTexture:Texture;
		
		public static function getDaisy():* {
			var mc:MovieClip = new MovieClip();
			var bmp:Bitmap = new Bitmap(daisyData);
			mc.addChild(bmp);
			return mc;
		}
		
		public static function getStarlingDaisy():* {
			if(!starlingTexture){
				starlingTexture = Texture.fromBitmapData(daisyData);
			}
			return new StarlingDaisy(starlingTexture);
		}
		
		public static function getND2DDaisy():* {
			if(!nd2dTexture){
				nd2dTexture = Texture2D.textureFromBitmapData(daisyData);
			}
			return new Sprite2D(nd2dTexture);
		}
	}
}
import starling.display.Image;
import starling.textures.Texture;

class StarlingDaisy extends Image {
	public var vx:Number;
	public var vy:Number;
	
	public function StarlingDaisy(texture:Texture){
		super(texture);
	}
	
}