package
{
	import org.flixel.FlxG;
	
	public class Glob
	{
		// these'll be accessed to get at sprites, controller, etc
		public static const kSpritinator:GSpritinator = new GSpritinator();
		public static const kController:GController = new GController();
		public static const kLeveler:GLeveler = new GLeveler();
		public static const kAudio:GAudio = new GAudio();
		
		// Flx G stuff
		public static function get debug():Boolean {return FlxG.debug;}
		public static function set debug($debug:Boolean):void {FlxG.debug = $debug;}
		public static function log($data:Object):void {FlxG.log($data);}
		public static function get width():Number {return FlxG.width;}
		public static function get height():Number {return FlxG.height;}
		public static function get elapsed():Number {return FlxG.elapsed;}
	}
}