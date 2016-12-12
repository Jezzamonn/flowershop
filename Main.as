package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Matrix;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import com.gskinner.utils.Rndm;
	
	
	public class Main extends MovieClip {
		
		public static var main:Main;
		
		public static const WIDTH:int = 100;
		public static const HEIGHT:int = 100;
		public static const BASE_SCALE:int = 2;
		public static const FULL_WIDTH:int = BASE_SCALE * WIDTH;
		public static const FULL_HEIGHT:int = BASE_SCALE * WIDTH;
		
		public var bitmapData:BitmapData;
		public var scaledBitmapData:BitmapData;
		public var bitmap:Bitmap;
		
		public var textBox:TextBox;
		public var hoverText:TextBox;
		public var workbench:Workbench;
		public var flowerShop:FlowerShop;
		
		public var state:int;
		public static const STATE_FLOWERSHOP:int = 0;
		public static const STATE_WORKBENCH:int = 1;
		
		public static var factorMapping:FactorMapping;
		public var customers:Array;
		public var score:int = 0;
		public var day:int = 0;
		
		public static const DIFFICULTIES:Array = [
			[0, 1],
			[1, 1, 0],
			[1, 1, 1],
			[2, 1, 0],
			[1, 2, 3],
			[3, 3, 0, 2],
			[3, 3, 3, 3],
		];
		
		public function Main() {
			main = this;
			// constructor code
			stage.quality = StageQuality.LOW;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0);
			scaledBitmapData = new BitmapData(FULL_WIDTH, FULL_HEIGHT, false, 0);
			bitmap = new Bitmap(scaledBitmapData);
			
			addChild(bitmap);
			
			textBox = new TextBox();
			textBox.x = 12;
			textBox.textField.width = FULL_WIDTH - (textBox.x * 2);
			
			hoverText = new TextBox();
			hoverText.textField.width = 150;
			
			
			Rndm.seed = int.MAX_VALUE * Math.random();
			
			factorMapping = new FactorMapping();
			
			startDay();
			
			SoundManager.init();
			SoundManager.playSong();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, resize);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			resize();
		}
		
		// events and stuff
		public function onEnterFrame(evt:Event):void {
			update();
			render();
		}
		
		public function update():void {
			var mousePoint:Point = bitmap.globalToLocal(new Point(mouseX, mouseY));
			mousePoint.x /= 2;
			mousePoint.y /= 2;
			
			hoverText.text = "";
			switch (state) {
				case STATE_FLOWERSHOP:
					flowerShop.checkHover(mousePoint.x, mousePoint.y);
					break;
				case STATE_WORKBENCH:
					workbench.checkHover(mousePoint.x, mousePoint.y);
					break;
			}
			
			hoverText.x = mousePoint.x * 2 - hoverText.textField.textWidth / 2;
			hoverText.y = mousePoint.y * 2 - hoverText.textField.textHeight - 5;
			
			if (hoverText.minX < 0) {
				hoverText.minX = 0;
			}
			else if (hoverText.maxX > FULL_WIDTH) {
				hoverText.maxX = FULL_WIDTH;
			}
			
			if (hoverText.minY < 0) {
				hoverText.minY = 0;
			}
			else if (hoverText.maxY > FULL_HEIGHT) {
				hoverText.maxY = FULL_HEIGHT;
			}
		}
		
		public function render():void {
			bitmapData.fillRect(bitmapData.rect, 0xFFFFFF);
			// draw stuff to the appropriate bitmap
			
			if (state == STATE_FLOWERSHOP) {
				flowerShop.render(bitmapData);
			}
			
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(BASE_SCALE, BASE_SCALE);
			
			scaledBitmapData.draw(bitmapData, scaleMatrix);
			
			switch (state) {
				case STATE_FLOWERSHOP:
					flowerShop.renderHighRes(scaledBitmapData);
					break;
				case STATE_WORKBENCH:
					workbench.renderHighRes(scaledBitmapData);
					scaledBitmapData.draw(workbench, scaleMatrix);
					break;
			}
			scaledBitmapData.draw(textBox, textBox.transform.matrix);
			scaledBitmapData.draw(hoverText, hoverText.transform.matrix);
		}
		
		public function resize(evt:Event = null):void {
			var xScale:Number = stage.stageWidth / bitmap.bitmapData.width;
			var yScale:Number = stage.stageHeight / bitmap.bitmapData.height;
			var scale:Number = Math.min(xScale, yScale);
			scale = Math.floor(scale);
			
			bitmap.scaleX = scale;
			bitmap.scaleY = scale;
			bitmap.x = (stage.stageWidth - scale * bitmap.bitmapData.width) / 2;
			bitmap.y = (stage.stageHeight - scale * bitmap.bitmapData.height) / 2;
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			switch (state) {
				case STATE_WORKBENCH:
					//workbench = new Workbench();
					break;
				case STATE_FLOWERSHOP:
					//flowerShop.onKeyDown(evt);
					break;
			}
			SoundManager.playSound();
			trace(SoundManager.currentChord);
		}
		
		public function onMouseDown(evt:MouseEvent):void {
			var mousePoint:Point = bitmap.globalToLocal(new Point(evt.stageX, evt.stageY));
			mousePoint.x /= 2;
			mousePoint.y /= 2;
			//trace(mousePoint);
			switch (state) {
				case STATE_WORKBENCH:
					workbench.onMouseDown(mousePoint.x, mousePoint.y);
					if (workbench.done) {
						state = STATE_FLOWERSHOP;
						flowerShop.plants = workbench.donePlants;
						flowerShop.goToPickup();
					}
					break;
				case STATE_FLOWERSHOP:
					if (flowerShop.done) {
						switch (flowerShop.state) {
							case FlowerShop.STATE_REQUEST:
								state = STATE_WORKBENCH;
								workbench.updateState();
								break;
							case FlowerShop.STATE_NIGHT:
								day ++;
								startDay();
								break;
						}
					}
					else {
						flowerShop.onMouseDown(mousePoint.x, mousePoint.y);
					}
					break;
			}
		}
		
		// Game stuff
		public function startDay():void {
			flowerShop = new FlowerShop();
			workbench = new Workbench();
			state = STATE_FLOWERSHOP;
			
			customers = [];
			if (day < DIFFICULTIES.length) {
				for (var i:int = 0; i < DIFFICULTIES[day].length; i ++) {
					var customer:Customer;
					do {
						customer = new Customer();
					}
					while (customers.length > 0 && customer.similarity(customers[customers.length-1]) <= 1);
					customer.setPreferences(DIFFICULTIES[day][i]);
					customers.push(customer);
				}
				Util.shuffle(customers);
				
				flowerShop.customers = customers;
				flowerShop.updateText();
			}
			else {
				flowerShop.state = FlowerShop.STATE_END;
				var total:int = 0;
				for each (var thing:* in DIFFICULTIES) {
					total += thing.length;
				}
				textBox.text = "That's the end of the week!\n" +
					"You made " + score + " people happy out of " + total + ".\n\n" +
					"Click to start a new week!";
				day = -1;
			}
		}
		
	}
	
}
