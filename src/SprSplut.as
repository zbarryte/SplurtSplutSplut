package
{
	import org.flixel.FlxG;
	
	public class SprSplut extends ZNode
	{
		private const kRot:Number = 1;
		private const kDragX:Number = 222;
		private const kDragY:Number = 222;
		private const kAccelY:Number = 222;
		private const kPropulsionVelocity:Number = 222;
		
		private var isFast:Boolean;
		private var isL:Boolean;
		private var isR:Boolean;
		
		private const kSounds:Array = [Glob.kAudio.kSplut01SFX,Glob.kAudio.kSplut02SFX,Glob.kAudio.kSplut03SFX,Glob.kAudio.kSplut04SFX,Glob.kAudio.kSplut05SFX,Glob.kAudio.kSplut06SFX,Glob.kAudio.kSplut07SFX,Glob.kAudio.kSplut08SFX,Glob.kAudio.kSplut09SFX,Glob.kAudio.kSplut10SFX,Glob.kAudio.kSplut11SFX,Glob.kAudio.kSplut12SFX]
		
		// to ensure that rotation's not tied to clock speed
		private const kTick:Number = 0.22;
		private var timer:Number;
		
		public function SprSplut($x:Number=0, $y:Number=0)
		{
			super($x, $y, Glob.kSpritinator.kSplut);

			drag.x = kDragX;
			drag.y = kDragY;
			acceleration.y = kAccelY;
			
			// set this in prep for counting time
			timer = 0;
		}
		
		private function doRotateL():void {rotateBy(-kRot*(isFast ? 2 : 1));}
		private function doRotateR():void {rotateBy(kRot*(isFast ? 2 : 1));}
		private function rotateBy($degrees:Number):void {
			angle += $degrees;
			// just to keep the math small (bounding blah blah blah...)
			if (angle >= 360) {angle -= 360;}
			if (angle < 0) {angle += 360;}
		}
		
		public function rotateL():void {isL = true;}
		public function rotateR():void {isR = true;}
		public function makeFast():void {isFast = true;}
		
		// shoot ink, propel
		public function ink():void {
			var $theta:Number = (angle - 90) * Math.PI / 180.0;
			var $cos:Number = Math.cos($theta);
			var $sin:Number = Math.sin($theta);
			velocity.x = $cos * kPropulsionVelocity * 1.5;
			velocity.y = $sin * kPropulsionVelocity;
			playSplutSound();
			scale.y = 0.66;
			scale.x = 1.44;
		}
		
		private function playSplutSound():void {
			var $index:uint = Math.random()*kSounds.length;
			var $class:Class = kSounds[$index];
			FlxG.play($class);
		}
		
		override public function update():void {
			super.update();
			// don't pass if not on tick
			timer += Glob.elapsed;
			if (timer < kTick) {return;}
			// now update stuff for the ticks
			if (isL) {doRotateL();}
			else if (isR) {doRotateR();}
			unsetAll();
			// reset the scale from splutting
			if (scale.y < 1) {scale.y+= 0.22; if (scale.y > 1) {scale.y=1;}}
			if (scale.x > 1) {scale.x-= 0.22; if (scale.x < 1) {scale.x=1;}}
		}
		
		private function unsetAll():void {
			isL = false;
			isR = false;
			isFast = false;
		}
	}
}