package
{
	import org.flixel.FlxG;
	
	public class StMenu extends ZState
	{
		override protected function createScene():void {
			addBkg();
			addText();
		}
		
		private function addBkg():void {
			var $bkg:ZNode = new ZNode();
			$bkg.loadGraphic(Glob.kSpritinator.kMnu);
			Glob.kSpritinator.centerNode($bkg);
			add($bkg);
		}
		
		private function addText():void {
			// title
			var $title:ZText = new ZText(0,0,Glob.width);
			$title.text = "Splurt Splot Splut";
			$title.alignment = "center";
			$title.size = 44;
			Glob.kSpritinator.centerNode($title);
			$title.y -= 44;
			add($title);
			// controls
			var $controls:ZText = new ZText(0,0,Glob.width);
			$controls.text = "Down to Splut\nLeft/Right to turn\nShift to SpeedTurning\n\nDown to begin Splutting!";
		
			$controls.size = 22;
			$controls.alignment = "center";
			Glob.kSpritinator.centerNode($controls);
			$controls.y += 44;
			add($controls);
		}
		
		override protected function updateControls():void {
			if (Glob.kController.justPressed(GController.kInk)) {
				begin();
			}
		}
		
		private function begin():void {
			var $switchState:Function = function():void {
				FlxG.switchState(new StPlay());
			};
			FlxG.fade(0xff004444,1,$switchState);
		}
	}
}