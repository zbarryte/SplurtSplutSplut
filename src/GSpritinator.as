package
{
	public class GSpritinator
	{
		public function GSpritinator()
		{
		}
		
		[Embed(source="assets/the_splut.png")] public const kSplut:Class;
		[Embed(source="assets/bkg.png")] public const kBkg:Class;
		[Embed(source="assets/mnu.png")] public const kMnu:Class;
		[Embed(source="assets/death_msg.png")] public const kDeathMsg:Class;
		[Embed(source="assets/block.png")] public const kBlock:Class;
		
		public function centerNodeX($node:ZNode):void {
			$node.x = Glob.width/2 - $node.width/2;
		}
		
		public function centerNodeY($node:ZNode):void {
			$node.y = Glob.height/2 - $node.height/2;
		}
		
		public function centerNode($node:ZNode):void {
			centerNodeX($node);
			centerNodeY($node);
		}
	}
}