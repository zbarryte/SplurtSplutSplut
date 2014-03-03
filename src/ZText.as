package
{
	import org.flixel.FlxText;
	
	public class ZText extends ZNode
	{
		protected var _text:FlxText;
		
		public function ZText($x:Number,$y:Number,$width:uint,$text:String=null,$embeddedFont:Boolean=true)
		{
			super($x,$y);
			
			_text = new FlxText($x,$y,$width,$text,$embeddedFont);
			width = _text.width;
			height = _text.height;
			
			_text.alpha = 0;
			alpha = 1;
		}
		
		override public function draw():void {
			_text.draw();
		}
		
		override public function update():void {
			_text.x = x;
			_text.y = y;
			_text.color = color;
			_text.angle = angle;
			_text.alpha = alpha;
			super.update();
		}
		
		public function set alignment($alignment:String):void {
			_text.alignment = $alignment;
		}
		
		public function get size():Number {return _text.size;}
		public function set size($size:Number):void {
			_text.size = $size;
		}
		
		public function set text($text:String):void {
			_text.text = $text;
		}
		
		public function set shadow($shadow:uint):void {
			_text.shadow = $shadow;
		}
	}
}