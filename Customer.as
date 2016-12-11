package  {
	import com.gskinner.utils.Rndm;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Bitmap;
	
	public class Customer {
		
		[Embed(source="graphics/people.png")]
		private static const IMAGE_CLASS:Class;
		private static var image:BitmapData;
		
		public var skin:int = 0;
		public var body:int = 0;
		public var hair:int = 0;
		public var hairColor:int = 0;
		public var bitmapData:BitmapData;
		
		public var plantType:PlantType;

		public function Customer() {
			plantType = new PlantType();
			
			if (!image) {
				image = (new IMAGE_CLASS() as Bitmap).bitmapData;
			}
			
			skin = Rndm.integer(4);
			body = Rndm.integer(4);
			hair = Rndm.integer(4);
			hairColor = Rndm.integer(4);
			
			var rect:Rectangle = new Rectangle(0, 0, 12, 15);
			bitmapData = new BitmapData(rect.width, rect.height, true, 0);
			
			rect.x = skin * rect.width;
			bitmapData.copyPixels(image, rect, new Point(), null, null, true);
			
			rect.y = rect.height;
			rect.x = body * rect.width;
			bitmapData.copyPixels(image, rect, new Point(), null, null, true);
			
			rect.y = 2 * rect.height;
			rect.x = hair * rect.width;
			bitmapData.copyPixels(image, rect, new Point(), null, null, true);
			
			var defaultHairColor:int = image.getPixel(4, 47);
			var newHairColor:int = image.getPixel(hairColor * rect.width + 4, 47);
			bitmapData.threshold(bitmapData, bitmapData.rect, new Point(), "==",
				defaultHairColor, 0xFF000000 + newHairColor, 0xFFFFFF);
		}
		
		public function randomisePreferences(difficulty:int = 1):void {
			// Select the preferences this person has
			var prefs:Array = [];
			for (var prop:* in PlantType.PROPERTIES) {
				prefs.push(prop);
			}
			
			while (prefs.length > difficulty) {
				var ranIndex:int = Rndm.integer(prefs.length);
				prefs.splice(ranIndex, 1);
			}
			
			for each (var pref in prefs) {
				plantType.randomise(pref);
			}
		}

	}
	
}
