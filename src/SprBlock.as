package
{
	public class SprBlock extends ZNode
	{
		private const kVelYRand:Number = 88;
		private const kVelYMin:Number = 44;
		
		public function SprBlock($x:Number=0, $y:Number=0, $simpleGraphic:Class=null)
		{
			super($x, $y, Glob.kSpritinator.kBlock);
			
			velocity.y = Math.random()*kVelYRand + kVelYMin;
			immovable = true;
		}
	}
}