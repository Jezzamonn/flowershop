package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class Workbench extends Sprite {
		
		public var textBox:TextBox;
		public var optionSprite:Sprite;
		public var plant:Plant;
		
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
			
			updateState();
		}
		
		public function updateState():void {
			// Clear existing options
			while (optionSprite.numChildren > 0) {
				optionSprite.removeChildAt(0);
			}
			
			switch (state) {
				case STATE_SEED:
				case STATE_FERTILIZER:
				case STATE_WATER:
					var numOptions:int = 4;
					for (var i:int = 0; i < numOptions; i ++) {
						var option:MovieClip;
						switch (state) {
							case STATE_SEED: // seeds
								option = new Seed();
								break;
							case STATE_FERTILIZER:
								option = new Fertilizer();
								break;
							case STATE_WATER:
								option = new WateringCan();
								break;
						}
						option.gotoAndStop(i + 1);
						
						option.x = (i + 1) * Main.WIDTH / (numOptions + 1);
						optionSprite.addChild(option);
					}
					break;
				default:
					plant = new Plant();
					plant.plantType.randomiseAll();
					plant.draw();
					plant.x = 0.5 * Main.WIDTH;
					plant.y = 0.7 * Main.HEIGHT;
					addChild(plant);
					break;
			}
		}

	}
	
}
