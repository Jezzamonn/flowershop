package {
	import com.gskinner.utils.Rndm;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Bitmap;

	public class Customer {

		[Embed(source = "graphics/people.png")]
		private static const IMAGE_CLASS:Class;
		private static var image:BitmapData;

		public var skin:int = 0;
		public var body:int = 0;
		public var hair:int = 0;
		public var hairColor:int = 0;
		public var bitmapData:BitmapData;

		public var plantType:PlantType;
		private var _happy:Boolean = false;
		public function get happy():Boolean {
			return _happy;
		}
		public function set happy(val:Boolean):void {
			_responseText = null;
			_happy = val;
		}

		public function Customer() {
			plantType = new PlantType();

			if (!image) {
				image = (new IMAGE_CLASS() as Bitmap).bitmapData;
			}

			skin = Rndm.integer(3);
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

			var defaultHairColor: int = image.getPixel(4, 47);
			var newHairColor: int = image.getPixel(hairColor * rect.width + 4, 47);
			bitmapData.threshold(bitmapData, bitmapData.rect, new Point(), "==",
				defaultHairColor, 0xFF000000 + newHairColor, 0xFFFFFF);
		}
		
		// how visually similar two people are
		public function similarity(customer:Customer):int {
			var difference:int = 0;
			if (skin != customer.skin) {
				difference ++;
			}
			if (body != customer.body) {
				difference ++;
			}
			if (hair != customer.hair) {
				difference ++;
			}
			if (hairColor != customer.hairColor) {
				difference ++;
			}
			return difference;
		}

		public function setPreferences(difficulty:int = 1): void {
			// Select the preferences this person has
			var prefs:Array = [];
			for (var prop: * in PlantType.PROPERTIES) {
				prefs.push(prop);
			}

			while (prefs.length > difficulty) {
				var ranIndex:int = Rndm.integer(prefs.length);
				prefs.splice(ranIndex, 1);
			}

			for each(var pref in prefs) {
				plantType.randomise(pref);
			}
		}

		private var _requestText:String;
		public function get requestText():String {
			if (!_requestText) {
				var out:String = "";
				out += Util.pickRandom(["Hi!", "Hi.", "Hey!", "Hey.", "Hello.", "Hi there."]);
				out += " I'd like " + plantType.description;
				if (Rndm.boolean(0.3)) {
					out += ", please!";
				} else {
					out += ".";
				}
				_requestText = out;
			}
			return _requestText;
		}
		
		private var _pickupText:String;
		public function get pickupText():String {
			if (!_pickupText) {
				_pickupText = Util.pickRandom([
					"I'm here to get my flower!",
					"Hello! Do you have my plant ready?",
					"Hi again! Can I pick up the plant?",
					"I'll grab that plant now, thanks."
				]);
			}
			return _pickupText;
		}
		
		private var _responseText:String;
		public function get responseText():String {
			if (!_responseText) {
				if (happy) {
					_responseText = Util.pickRandom([
						"Great! This is exactly what I want!",
						"Perfect!",
						"Thanks!",
						"Wow! It's great!",
						"Thank you."
					]);
				}
				else {
					_responseText = Util.pickRandom([
						"Oh. This isn't what I ordered.",
						"Hm. This isn't quite right.",
						"This isn't what I wanted!",
						"Sorry, this isn't right.",
						"Er... Did you forget my order?"
					]);
				}
			}
			return _responseText;
		}

	}

}