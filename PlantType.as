package  {
	import com.gskinner.utils.Rndm;
	
	public class PlantType {

		public static const FLOWER_COLOR_MULTS:Object = {
			red: [0.7, 0.3, 0.3],
			pink: [0.8, 0.6, 0.6],
			blue: [0.3, 0.4, 0.6],
			orange: [0.7, 0.5, 0.3],
			purple: [0.6, 0.4, 0.6]
		};
		
		public static const PROPERTIES:Object = {
			flowerShape: ["rose", "spikey", "tissue box", "ball-shaped"],
			leafShape: ["smooth", "jagged", "spikey", "heart-shaped"],
			flowerColor: ["red", "pink", "blue", "orange", /*"purple"*/]
		};
		
		public static const FACTORS:Object = {
			seedType: ["oval", "small", "long", "lumpy"],
			fertilizer: ["kelp meal", "bone meal", "soybean meal", "agricultural lime"],
			waterAmount: ["none", "little", "medium", "lots"]
		};
		
		public var flowerShape:String;
		public var leafShape:String;
		public var flowerColor:String;
		
		public function PlantType(flowerShape:String = null, leafShape:String = null, flowerColor:String = null) {
			// load values given, or otherwise pick randomly
			this.flowerShape = flowerShape;
			this.flowerColor = flowerColor;
			this.leafShape = leafShape;
		}
		
		public function randomise(prop:String):void {
			this[prop] = Util.pickRandom(PROPERTIES[prop]);
		}
		
		public function randomiseAll():void {
			for (var prop:* in PROPERTIES) {
				randomise(prop);
			}
		}
		
		public function get leafShapeIndex():int {
			return PROPERTIES["leafShape"].indexOf(leafShape);
		}
		
		public function get flowerShapeIndex():int {
			return PROPERTIES["flowerShape"].indexOf(flowerShape);
		}
		
		public function get flowerColorMults():Array {
			return FLOWER_COLOR_MULTS[flowerColor];
		}
		
		public function get description():String {
			if (flowerColor == null && flowerShape == null && leafShape == null) {
				return "any plant";
			}
			
			var description:String = "a plant with "
			if (flowerColor) {
				description += flowerColor;
			}
			if (flowerShape) {
				if (flowerColor) {
					description += ", ";
				}
				description += flowerShape;
			}
			if (flowerColor || flowerShape) {
				description += " flowers";
			}
			
			if (leafShape) {
				if (flowerShape || flowerColor) {
					description += " and ";
				}
				description += leafShape + " leaves";
			}
			return description;
		}

	}
	
}
