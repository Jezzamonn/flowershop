package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	
	public class Workbench extends Sprite {
		
		public var optionSprite:Sprite;
		public var plant:Plant;
		
		public var donePlants:Array = [];
		
		public var state:int = 0;
		public static const STATE_INSTRUCTIONS:int = -1;
		public static const STATE_SEED:int = 0;
		public static const STATE_FERTILIZER:int = 1;
		public static const STATE_WATER:int = 2;
		public static const STATE_GROWING:int = 3;
		public static const STATE_DONE_GROW:int = 4;
		
		public var seedType:String;
		public var fertilizer:String;
		public var waterAmount:String;
		
		public static const INSTRUCTIONS:Array = [
			"This is the workbench, where I do all my growing.",
			"You can grow plants by clicking on what seeds, what fertilizer and how much water to use.",
			"They each seem to affect the plants differently each week! But day-to-day they're the same.",
			"And remember, you only have 4 pots to experiment with.",
			"Let's get growing!",
		];
		public static var instructionIndex:int = 0;

		public function Workbench() {
			donePlants = [];
			
			optionSprite = new Sprite();
			optionSprite.y = 0.9 * Main.HEIGHT;
			addChild(optionSprite);
		}
		
		public function renderHighRes(context:BitmapData):void {
			context.fillRect(context.rect, 0xf6efe5);
		}
		
		public function selectOption(index:int):void {
			var factorName:String;
			switch (state) {
				case STATE_SEED:
					factorName = "seedType";
					break;
				case STATE_FERTILIZER:
					factorName = "fertilizer";
					break;
				case STATE_WATER:
					factorName = "waterAmount";
					break;
			}
			this[factorName] = PlantType.FACTORS[factorName][index];
			//trace(factorName + " = " + this[factorName]);
			
			state ++;
			updateState();
		}
		
		public function onMouseDown(mouseX:Number, mouseY:Number):void {
			// circular hitboxes, good enough
			if (instructionIndex < INSTRUCTIONS.length) {
				instructionIndex ++;
				updateState();
				return;
			}
			
			if (state == STATE_GROWING) {
				state = STATE_DONE_GROW;
				updateState();
			}
			else if (state >= STATE_DONE_GROW) {
				state = 0;
				donePlants.push(plant);
				plant.x = donePlants.length * 0.2 * Main.WIDTH;
				plant.y = 0.3 * Main.HEIGHT;
				plant.scaleX = 0.15;
				plant.scaleY = 0.15;
				plant.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 50, 50, 50);
				
				plant = null
				updateState();
			}
			else {
				var child:MovieClip = Util.getCloseChild(optionSprite, mouseX, mouseY) as MovieClip;
				if (child) {
					selectOption(child.currentFrame - 1);
					SoundManager.playSound();
				}
			}
		}
		
		public function checkHover(mouseX:Number, mouseY:Number):void {
			switch (state) {
				case STATE_SEED:
				case STATE_FERTILIZER:
				case STATE_WATER:
					var closest:MovieClip = Util.getCloseChild(optionSprite, mouseX, mouseY) as MovieClip;
					if (closest) {
						var index:int = closest.currentFrame - 1;
						switch (state) {
							case STATE_SEED: // seeds
								Main.main.hoverText.text = PlantType.FACTORS["seedType"][index];
								break;
							case STATE_FERTILIZER:
								Main.main.hoverText.text = PlantType.FACTORS["fertilizer"][index];
								break;
							case STATE_WATER:
								Main.main.hoverText.text = PlantType.FACTORS["waterAmount"][index];
								break;
						}
					}
					break;
			}
		}

		public function update():void {
			if (state >= STATE_GROWING) {
				plant.growBranches();
				plant.drawBranches();
			}
		}
		
		public function updateState():void {
			// Clear existing options
			while (optionSprite.numChildren > 0) {
				optionSprite.removeChildAt(0);
			}
			
			Main.main.textBox.text = "";
			if (instructionIndex < INSTRUCTIONS.length) {
				Main.main.textBox.text = INSTRUCTIONS[instructionIndex];
				//return;
			}
			
			if (donePlants.length >= 4) {
				return;
			}
			
			if (plant == null) {
				plant = new Plant();
				plant.draw();
				plant.scaleX = 0.35;
				plant.scaleY = 0.35;
				plant.x = 0.5 * Main.WIDTH;
				plant.y = 0.82 * Main.HEIGHT;
				addChildAt(plant, getChildIndex(optionSprite));
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
						option.scaleX = 0.2;
						option.scaleY = 0.2;
						option.x = (i + 1) * Main.WIDTH / (numOptions + 1);
						optionSprite.addChild(option);
					}
					break;
				case STATE_GROWING:
					plant.plantType = Main.factorMapping.createFromFactors(seedType, fertilizer, waterAmount);
					plant.draw();
					break;
				case STATE_DONE_GROW:
					plant.fullyGrow();
					Main.main.textBox.text = "You grew " + plant.plantType.description + "!";
					break;
			}
		}
		
		public function get done():Boolean {
			return donePlants.length >= 4;
		}

	}
	
}
