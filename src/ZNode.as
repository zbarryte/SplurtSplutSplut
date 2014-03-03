package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	
	public class ZNode extends FlxSprite
	{
		public var xLocal:Number;
		public var yLocal:Number;
		
		protected var _graphic:Class;
		protected var _children:FlxGroup;
		
		public function ZNode($x:Number=0,$y:Number=0,$simpleGraphic:Class=null)
		{
			xLocal = $x;
			yLocal = $y;
			super(xLocal,yLocal,$simpleGraphic);
			
			_children = new FlxGroup();
			_graphic = $simpleGraphic;
		}
		
		override public function loadGraphic($graphic:Class,$animated:Boolean=false,$reverse:Boolean=false,$width:uint=0,$height:uint=0,$unique:Boolean=false):FlxSprite {
			_graphic = $graphic;
			return super.loadGraphic($graphic,$animated,$reverse,$width,$height,$unique);
		}
		
		public function add($child:ZNode):void {
			_children.add($child);
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < _children.length; i++) {
				var $child:ZNode = _children.members[i];
				updateChildProperties($child);
			}
		}
		
		private function updateChildProperties($child:ZNode):void {
			$child.velocity = velocity;
			$child.acceleration = acceleration;
			$child.x = x + $child.xLocal;
			$child.y = y + $child.yLocal;
			$child.update();
		}
		
		override public function preUpdate():void {
			super.preUpdate();
			for (var i:uint = 0; i < _children.length; i++) {
				var $child:ZNode = _children.members[i];
				$child.preUpdate();
			}
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			for (var i:uint = 0; i < _children.length; i++) {
				var $child:ZNode = _children.members[i];
				$child.postUpdate();
			}
		}
		
		override public function draw():void {
			if (!visible || !_graphic) {return;}
			super.draw();
			_children.draw();
		}
	}
}