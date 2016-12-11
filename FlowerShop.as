package  {
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Matrix;
	import com.gskinner.utils.Rndm;
	import flash.events.MouseEvent;
	
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
		public var textBox:TextBox;

		public function FlowerShop() {
			// constructor code
			if (!image) {
				image = (new IMAGE_CLASS() as Bitmap).bitmapData;
			}
			
			textBox = new TextBox();
			textBox.width = Main.FULL_WIDTH;
			textBox.text = "HELLO!!!!!!"
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			// NOTHING!
		}
		
		public function onMouseDown(evt:MouseEvent):void {
			customerIndex ++;
			if (currentCustomer) {
				textBox.text = currentCustomer.requestText;
			}
			else {
				textBox.text = "";
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
		}
		
		public function renderHighRes(context:BitmapData):void {
			context.draw(textBox);
		}

	}
	
}
