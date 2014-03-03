package
{
	import org.flixel.FlxG;
	
	public class GController
	{	
		public static const kLeft:Array = ["LEFT"];
		public static const kRight:Array = ["RIGHT"];
		public static const kInk:Array = ["DOWN"];
		public static const kSpeed:Array = ["SHIFT"];
		public static const kBack:Array = ["ESCAPE"];
		
		/**
		 * Checks whether or not any of the keys in the array is being pressed. Wraps <code>FlxG.keys.pressed</code>
		 * 
		 * @param	$keys		An array of keys to check
		 * 
		 * @return	Whether any of the keys is being pressed
		 */
		public function pressed($keys:Array):Boolean {
			for (var i:uint = 0; i < $keys.length; i++) {
				if (FlxG.keys.pressed($keys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the keys in the array were just pressed. Wraps <code>FlxG.kys.justPressed</code>
		 * 
		 * @param	$keys		An array of keys to check
		 * 
		 * @return 	Whether any of the keys were just pressed
		 */
		public function justPressed($keys:Array):Boolean {
			for (var i:uint = 0; i < $keys.length; i++) {
				if (FlxG.keys.justPressed($keys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the keys in the array were just released. Wraps <code>FlxG.keys.justReleased</code>
		 * 
		 * @param	$keys		An array of keys to check
		 * 
		 * @return	Whether any of the keys were just released
		 */
		public function justReleased($keys:Array):Boolean {
			for (var i:uint = 0; i <$keys.length; i++) {
				if (FlxG.keys.justReleased($keys[i])) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks whether or not any of the primary keys have priority over the secondary keys. Priority is given to the key last pressed and still held.
		 * 
		 * @param	$keysPrimary		An array of primary keys
		 * @param 	$keysSecondary	An array of secondary keys
		 * 
		 * @return	Whether or not the primary keys have priority over the secondary keys.
		 */
		public function pressedAfter($keysPrimary:Array,$keysSecondary:Array):Boolean {
			return pressed($keysPrimary) && (justPressed($keysPrimary) || !pressed($keysSecondary));
		}
	}
}