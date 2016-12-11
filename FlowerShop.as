package  {
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	public class FlowerShop {
		
		[Embed(source="graphics/frame.png")]
		private static const IMAGE_CLASS:Class;
		
		private static var image:BitmapData;

		public function FlowerShop() {
			// constructor code
			if (!image) {
				image = (new IMAGE_CLASS() as Bitmap).bitmapData;
			}
		}
		
		public function render(context:BitmapData):void {
			context.fillRect(context.rect, 0xb4e2ea);
			context.copyPixels(image, image.rect, new Point(), null, null, true);
		}

	}
	
}
