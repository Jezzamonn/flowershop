package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class Workbench extends Sprite {
		
		public var textBox:TextBox;
		public var optionSprite:Sprite;
		
		public var state:int = 0;
		public static const STATE_SEED:int = 0;
		public static const STATE_FERTILIZER:int = 1;
		public static const STATE_WATER:int = 2;

		public function Workbench() {
			textBox = new TextBox();
			textBox.width = 600;
			
			optionSprite = new Sprite();
			optionSprite.y = 0.7 * Main.HEIGHT;
			addChild(optionSprite);
			
			addOptions();
		}
		
		public function addOptions():void {
			// TODO
			switch (state) {
				case STATE_SEED: // seeds
					
					break;
				case STATE_FERTILIZER:
					
					break;
				case STATE_WATER:
					
					break;
			}
			
			var numOptions:int = 4;
			for (var i:int = 0; i < numOptions; i ++) {
				var option:MovieClip = new Seed();
				option.gotoAndStop(i + 1);
				
				option.x = (i + 1) * Main.WIDTH / (numOptions + 1);
				optionSprite.addChild(option);
			}
		}

	}
	
}
