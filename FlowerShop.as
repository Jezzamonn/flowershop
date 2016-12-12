package  {
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Matrix;
	import com.gskinner.utils.Rndm;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	
	public class FlowerShop {
		
		[Embed(source="graphics/frame.png")]
		private static const IMAGE_CLASS:Class;
		private static var image:BitmapData;
		
		[Embed(source="graphics/title.png")]
		private static const TITLE_CLASS:Class;
		public static var title:BitmapData;
		
		{
			image = (new IMAGE_CLASS() as Bitmap).bitmapData;
			title = (new TITLE_CLASS() as Bitmap).bitmapData;
		}
		
		public var customerIndex:int = 0;
		public function get currentCustomer():Customer {
			if (customers && customerIndex >= 0 && customerIndex < customers.length) {
				return customers[customerIndex];
			}
			return null;
		}
		public var customers:Array;
		public var plants:Array;
		public var curPlant:Plant;
		public var plantSprite:Sprite;
		
		public var state:int;
		public static const STATE_REQUEST:int = 0;
		public static const STATE_PICKUP:int = 1;
		public static const STATE_NIGHT:int = 2;
		public static const STATE_END:int = 3;

		public var substate:int;
		public static const SUBSTATE_PICK_FLOWER:int = 0;
		public static const SUBSTATE_RESPONSE:int = 1;
		
		public static const INSTRUCTIONS:Array = [
			"",
			"Hi! This is my flower shop. It's very small -- just one room!\n\n(Click to continue)",
			"Each day, customers come past and make an order, and it's my job to grow it for them.",
			"How about you give me a hand this week?",
			"I get a new set of seeds each week, but I can never remember which ones grow into what!",
			"And depending on how much water, and what fertilizer I use they turn out very different...",
			"I can only fit 4 pots in this room, so you've got that many tries to get their orders right",
			"Oh, and make sure you remember what everyone ordered and give them the right plant!",
			"Hey, here comes a customer now! Good luck! <3"
		]
		public static var instructionIndex:int = 0;
		
		public function FlowerShop() {
			// constructor code
			plantSprite = new Sprite();
			plants = [];
			
			if (instructionIndex < INSTRUCTIONS.length) {
				customerIndex = -1;
			}
			
			updateText();
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			// NOTHING!
		}
		
		public function onMouseDown(mouseX:Number, mouseY:Number):void {
			if (instructionIndex < INSTRUCTIONS.length) {
				instructionIndex ++;
				if (instructionIndex >= INSTRUCTIONS.length) {
					customerIndex = 0;
				}
			}
			else {
				switch (state) {
					case STATE_REQUEST:
						customerIndex ++;
						break;
					case STATE_PICKUP:
						switch (substate) {
							case SUBSTATE_PICK_FLOWER:
								pickFlower(mouseX, mouseY);
								break;
							case SUBSTATE_RESPONSE:
								customerIndex ++;
								if (customerIndex >= customers.length) {
									state = STATE_NIGHT;
								}
								else {
									substate = 0;
								}
								break;
						}
						break;
					case STATE_END:
						state = STATE_NIGHT;
						break;
				}
			}
			updateText();
		}
		
		public function checkHover(mouseX:Number, mouseY:Number):void {
			var plant:Plant = Util.getCloseChild(plantSprite, mouseX, mouseY) as Plant;
			if (plant) {
				Main.main.hoverText.text = plant.plantType.hoverText;
			}
		}
		
		public function pickFlower(mouseX:Number, mouseY:Number):void {
			var plant:Plant = Util.getCloseChild(plantSprite, mouseX, mouseY) as Plant;
			if (plant) {
				plantSprite.removeChild(plant);
				givePlant(plant);
			}
		}
		
		public function givePlant(plant:Plant):void {
			substate ++;
			curPlant = plant;
			if (curPlant.plantType.matchesRequest(currentCustomer.plantType)) {
				currentCustomer.happy = true;
				Main.main.score ++;
			}
			else {
				currentCustomer.happy = false;
			}
			updateText();
		}
		
		public function updateText():void {
			Main.main.textBox.text = "";
			if (instructionIndex < INSTRUCTIONS.length) {
				Main.main.textBox.text = INSTRUCTIONS[instructionIndex];
				return;
			}
			
			if (currentCustomer) {
				switch (state) {
					case STATE_REQUEST:
						Main.main.textBox.text = currentCustomer.requestText;
						break;
					case STATE_PICKUP:
						switch (substate) {
							case SUBSTATE_PICK_FLOWER:
								Main.main.textBox.text = currentCustomer.pickupText;
								break;
							case SUBSTATE_RESPONSE:
								Main.main.textBox.text = currentCustomer.responseText;
								break;
						}
						break;
				}
			}
		}
		
		public function render(context:BitmapData):void {
			switch (state) {
				case STATE_REQUEST:
				default:
					context.fillRect(context.rect, 0xb4e2ea);
					break;
				case STATE_NIGHT:
					context.fillRect(context.rect, 0x333e58);
					break;
				case STATE_PICKUP:
					context.fillRect(context.rect, 0xcba569);
					break;
			}
			
			// Render customer here
			if (currentCustomer) {
				var translateMatrix:Matrix = new Matrix();
				translateMatrix.translate(44, 55);
				context.draw(currentCustomer.bitmapData, translateMatrix);
			}
			
			context.copyPixels(image, image.rect, new Point(), null, null, true);
			
			for (var i:int = 0; i < plants.length; i ++) {
				context.draw(plantSprite);
			}
			
			if (state == STATE_NIGHT) {
				context.draw(context, null, new ColorTransform(0.3, 0.4, 0.5));
			}
			if (state == STATE_PICKUP) {
				context.draw(context, null, new ColorTransform(0.95, 0.8, 0.7));
			}
			
			if (instructionIndex == 0) {
				context.copyPixels(title, title.rect, new Point(), null, null, true);
			}
			
		}
		
		public function renderHighRes(context:BitmapData):void {
			if (instructionIndex == 0) {
				var textBox2:TextBox = new TextBox();
				textBox2.textFormat.color = 0x765834;
				textBox2.textField.defaultTextFormat = textBox2.textFormat;
				textBox2.textField.width = Main.FULL_WIDTH;
				textBox2.text = "a Ludum Dare game by @jezzamonn";
				textBox2.bgShape.alpha = 0.2;
				textBox2.x = 0.15 * Main.FULL_WIDTH;
				textBox2.y = 0.3 * Main.FULL_HEIGHT;
				context.draw(textBox2, textBox2.transform.matrix);
			}
		}
		
		public function goToPickup():void {
			state = STATE_PICKUP;
			substate = 0;
			customerIndex = 0;
			
			for (var i:int = 0; i < plants.length; i ++) {
				var plant:Plant = plants[i];
				plant.x = (i + 1) * 0.2 * Main.WIDTH;
				plant.y = 0.95 * Main.HEIGHT;
				plant.scaleX = 0.1;
				plant.scaleY = 0.1;
				plant.transform.colorTransform = new ColorTransform();
				plantSprite.addChild(plant);
			}
			
			updateText();
		}
		
		public function get done():Boolean {
			switch (state) {
				case STATE_NIGHT:
					return true;
				case STATE_REQUEST:
					return customerIndex >= customers.length - 1;
			}
			return false;
		}

	}
	
}
