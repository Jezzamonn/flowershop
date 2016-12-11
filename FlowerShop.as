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
	
	public class FlowerShop {
		
		[Embed(source="graphics/frame.png")]
		private static const IMAGE_CLASS:Class;
		private static var image:BitmapData;
		
		public var customerIndex:int = -1;
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
		public var textBox:TextBox;
		
		public var state:int;
		public static const STATE_REQUEST:int = 0;
		public static const STATE_PICKUP:int = 1;

		public var substate:int;
		public static const SUBSTATE_PICK_FLOWER:int = 0;
		public static const SUBSTATE_RESPONSE:int = 1;
		
		public function FlowerShop() {
			// constructor code
			if (!image) {
				image = (new IMAGE_CLASS() as Bitmap).bitmapData;
			}
			
			textBox = new TextBox();
			textBox.width = Main.FULL_WIDTH;
			textBox.text = "HELLO!!!!!!"
			
			plantSprite = new Sprite();
			
			plants = [];
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			// NOTHING!
		}
		
		public function onMouseDown(mouseX:Number, mouseY:Number):void {
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
							substate = 0;
							break;
					}
					break;
			}
			updateText();
		}
		
		public function pickFlower(mouseX:Number, mouseY:Number):void {
			for (var i:int = 0; i < plantSprite.numChildren; i ++) {
				var child:Plant = plantSprite.getChildAt(i) as Plant;
				var xDif:Number = plantSprite.x + child.x - mouseX;
				var yDif:Number = plantSprite.y + child.y - mouseY;
				var r2Dif = xDif * xDif + yDif * yDif;
				
				if (r2Dif < 10 * 10) {
					plantSprite.removeChild(child);
					givePlant(child);
					return;
				}
			}
		}
		
		public function givePlant(plant:Plant):void {
			substate ++;
			curPlant = plant;
			if (curPlant.plantType.matchesRequest(currentCustomer.plantType)) {
				currentCustomer.happy = true;
			}
			updateText();
		}
		
		public function updateText():void {
			textBox.text = "";
			
			if (currentCustomer) {
				switch (state) {
					case STATE_REQUEST:
						textBox.text = currentCustomer.requestText;
						break;
					case STATE_PICKUP:
						switch (substate) {
							case SUBSTATE_PICK_FLOWER:
								textBox.text = currentCustomer.pickupText;
								break;
							case SUBSTATE_RESPONSE:
								textBox.text = currentCustomer.responseText;
						}
						break;
				}
			}
		}
		
		public function render(context:BitmapData):void {
			context.fillRect(context.rect, 0xb4e2ea);
			
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
			
		}
		
		public function renderHighRes(context:BitmapData):void {
			context.draw(textBox);
		}
		
		public function goToPickup():void {
			state = STATE_PICKUP;
			substate = 1;
			customerIndex = -1;
			
			for (var i:int = 0; i < plants.length; i ++) {
				var plant:Plant = plants[i];
				plant.x = (i + 1) * 0.2 * Main.WIDTH;
				plant.y = 0.9 * Main.HEIGHT;
				plant.scaleX = 0.1;
				plant.scaleY = 0.1;
				plantSprite.addChild(plant);
			}
		}
		
		public function get done():Boolean {
			return customerIndex >= customers.length;
		}

	}
	
}
