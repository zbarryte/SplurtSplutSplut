package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	
	public class StPlay extends ZState
	{
		private var splut:SprSplut;
		private var isPlaying:Boolean;
		private var deathMsg:ZNode;
		
		private var blockTimer:Number;
		private var blockPeriod:Number = 2;
		private const kBlockPeriodMin:Number = 0.22;
		private var bounds:FlxTilemap;
		
		private var blockGroup:FlxGroup;
		private const kBlocksMax:uint = 5;
		
		private var deathText:ZText;
		private var score:uint;
		private var scoreText:ZText;
		private var scoreTimer:Number;
		private const kScorePeriod:uint = 1;
		
		private const kSpeedUpPeriod:uint = 5;
		private var speedUpTimer:Number;
		
		override protected function createScene():void {
			blockTimer = 0;
			speedUpTimer = 0;
			score = 0;
			scoreTimer = 0;
			addBkg();
			addBlockGroup();
			addSplut();
			addScore();
			createDeathMsg();
			createBounds();
			resume();
		}
		
		private function addScore():void {
			scoreText = new ZText(0,0,Glob.width);
			scoreText.size = 14;
			setScore();
			add(scoreText);
		}
		
		private function addBkg():void {
			var $bkg:ZNode = new ZNode();
			$bkg.loadGraphic(Glob.kSpritinator.kBkg);
			Glob.kSpritinator.centerNode($bkg);
			add($bkg);
			
		}
		
		private function addBlockGroup():void {
			blockGroup = new FlxGroup();
			add(blockGroup);
		}
		
		private function addSplut():void {
			splut = new SprSplut();
			Glob.kSpritinator.centerNode(splut);
			add(splut);
		}
		
		private function createDeathMsg():void {
			// death bkg msg
			deathMsg = new ZNode();
			deathMsg.loadGraphic(Glob.kSpritinator.kDeathMsg);
			Glob.kSpritinator.centerNode(deathMsg);
			// death text
			var $deathBuffer:uint = 8;
			deathText = new ZText($deathBuffer,$deathBuffer*5,deathMsg.width - $deathBuffer);
			deathText.text = "Press Down to reSplut\n\n Press Esc to give up...";
			deathMsg.add(deathText);
			deathText.alignment = "center";
			deathText.size = 19;
		}
		
		private function createBounds():void {
			bounds = new FlxTilemap();
			bounds.loadMap(new Glob.kLeveler.kBounds,Glob.kLeveler.kTiles,32,32);
			bounds.x = Glob.width/2 - bounds.width/2;
			bounds.y = Glob.height/2 -bounds.height/2;
			add(bounds);
		}
		
		override protected function updateControls():void {
			// gotta go fast?
			if (Glob.kController.pressed(GController.kSpeed)) {
				splut.makeFast();
			}
			// angle the splut left or right
			if (Glob.kController.pressedAfter(GController.kLeft,GController.kRight)) {
				splut.rotateL();
			} else if (Glob.kController.pressedAfter(GController.kRight,GController.kLeft)) {
				splut.rotateR();
			}
			// fire! (backwards, because it's a splut shooting ink or whatever)
			if (Glob.kController.justPressed(GController.kInk)) {
				splut.ink();
			}
		}
		
		override public function update():void {
			if (isPlaying) {
				super.update();
				updateScene();
			} else {
				updateLose();
			}
		}
		
		private function updateScene():void {
			FlxG.collide(splut,bounds);
			FlxG.collide(splut,blockGroup);
			checkIfSplutIsPushedTooFarDown();
			dropBlocksEverySoOften();
			//removeLowBlocks();
			updateScore();
			speedUpEachPeriod();
		}
		
		private function speedUpEachPeriod():void {
			speedUpTimer += Glob.elapsed;
			if (blockPeriod == kBlockPeriodMin || speedUpTimer < kSpeedUpPeriod) {return;}
			speedUpTimer = 0;
			blockPeriod -= 0.22;
			if (blockPeriod < kBlockPeriodMin) {blockPeriod == kBlockPeriodMin;}
		}
		
		private function updateScore():void {
			scoreTimer += Glob.elapsed;
			if (scoreTimer < kScorePeriod) {return;}
			score ++;
			scoreTimer = 0;
			setScore()
		}
		
		private function setScore():void {
			scoreText.text = "Score: "+score;
		}
		
		private function dropBlocksEverySoOften():void {
			blockTimer += Glob.elapsed;
			if (blockTimer >= blockPeriod) {
				blockTimer = 0;
				// choose a random number of blocks to make
				var $numBlocks:uint = uint(Math.random()*kBlocksMax);
				for (var i:uint = 0; i < $numBlocks; i++) {
					// create a new block along the top somewhere
					var $block:SprBlock = new SprBlock();
					var $numCols:uint = Glob.width/$block.width;
					var $xSpawn:Number = uint(Math.random()*($numCols));
					Glob.log($xSpawn);
					$xSpawn *= $block.width;
					var $ySpawn:Number = -$block.height;
					$block.x = $xSpawn;
					$block.y = $ySpawn;
					blockGroup.add($block);
				}
			}
		}
		
		private function removeLowBlocks():void {
			var $removeGroup:FlxGroup = new FlxGroup;
			for (var i:uint = 0; i < blockGroup.length; i++) {
				var $block:SprBlock = blockGroup.members[i];
				if ($block.y >= Glob.height) {
					$removeGroup.add($block);
				}
			}
			for (var j:uint = 0; j < $removeGroup.length; j++) {
				var $removeBlock:SprBlock = $removeGroup.members[j];
				blockGroup.remove($removeBlock);
			}
		}
		
		private function updateLose():void {
			deathMsg.update();
			if (Glob.kController.justPressed(GController.kInk)) {
				continueLoss();
			} else if (Glob.kController.justPressed(GController.kBack)) {
				acceptLoss();
			}
		}
		
		private function checkIfSplutIsPushedTooFarDown():void {
			if (splut.y >= Glob.height) {lose();}
		}
		
		private function lose():void {
			addDeathMsg();
			pause();
		}
		
		private function addDeathMsg():void {
			add(deathMsg);
		}
		
		private function acceptLoss():void {
			var $switchState:Function = function():void {
				FlxG.switchState(new StMenu());
			};
			FlxG.fade(0xff000000,1,$switchState);
		}
		
		private function continueLoss():void {
			var $switchState:Function = function():void {
				FlxG.switchState(new StPlay());
			};
			FlxG.fade(0xff000000,1,$switchState);
		}
		
		private function pause():void {isPlaying = false;}
		private function resume():void {isPlaying = true;}
	}
}