package  {
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.Matrix;
	import com.gskinner.utils.Rndm;
	
	public class FlowerShop {
		
		[Embed(source="graphics/frame.png")]
		private static const IMAGE_CLASS:Class;
		private static var image:BitmapData;
		
		public var currentCustomer:Customer;
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
			switch (evt.keyCode) {
				case Keyboard.R:
					currentCustomer = new Customer();
					currentCustomer.setPreferences(Rndm.integer(4));
					textBox.text = currentCustomer.requestText;
					break;
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
