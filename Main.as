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
	
	
	public class Main extends MovieClip {
		
		public static const WIDTH:int = 100;
		public static const HEIGHT:int = 100;
		public static const BASE_SCALE:int = 2;
		public static const FULL_WIDTH:int = BASE_SCALE * WIDTH;
		public static const FULL_HEIGHT:int = BASE_SCALE * WIDTH;
		
		public var bitmapData:BitmapData;
		public var scaledBitmapData:BitmapData;
		public var bitmap:Bitmap;
		
		public var textBox:TextBox;
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
			[1, 1, 1],
			[1, 1, 2],
			[2, 2, 3],
			[3, 3, 3, 3],
		];
		
		public function Main() {
			// constructor code
			stage.quality = StageQuality.LOW;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0);
			scaledBitmapData = new BitmapData(FULL_WIDTH, FULL_HEIGHT, false, 0);
			bitmap = new Bitmap(scaledBitmapData);
			
			addChild(bitmap);
			
			textBox = new TextBox();
			textBox.width = stage.stageWidth;
			//addChild(textBox);
			workbench = new Workbench();
			flowerShop = new FlowerShop();
			
			factorMapping = new FactorMapping();
			
			startDay();
			
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
			// nothing yet
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
					scaledBitmapData.draw(workbench, scaleMatrix);
					break;
			}
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
					workbench = new Workbench();
					break;
				case STATE_FLOWERSHOP:
					flowerShop.onKeyDown(evt);
					break;
			}
		}
		
		public function onMouseDown(evt:MouseEvent):void {
			switch (state) {
				case STATE_WORKBENCH:
					//workbench.onMouseDown(evt);
					break;
				case STATE_FLOWERSHOP:
					flowerShop.onMouseDown(evt);
					if (flowerShop.customerIndex > flowerShop.customers.length) {
						state = STATE_WORKBENCH;
					}
					break;
			}
		}
		
		// Game stuff
		public function startDay():void {
			customers = [];
			for (var i:int = 0; i < DIFFICULTIES[day].length; i ++) {
				var customer:Customer = new Customer();
				customer.setPreferences(DIFFICULTIES[day][i]);
				customers.push(customer);
			}
			Util.shuffle(customers);
			
			flowerShop.customers = customers;
		}
		
	}
	
}
