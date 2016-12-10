﻿package  {
	import com.gskinner.utils.Rndm;
	
	public class PlantType {

		public static const FLOWER_SHAPES:Array = [
			"rose", "sketchy", "tissue box",
		];
		public static const LEAF_SHAPES:Array = [
			"smooth", "jagged", "spikey",
		];
		public static const FLOWER_COLORS:Array = [
			"red", "pink", "blue", "orange", "purple",
		];
		public static const FLOWER_COLOR_MULTS:Object = {
			red: [0.7, 0.3, 0.3],
			pink: [0.8, 0.6, 0.6],
			blue: [0.3, 0.4, 0.6],
			orange: [0.7, 0.5, 0.3],
			purple: [0.6, 0.4, 0.6]
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
		
		public function randomise():void {
			flowerShape = pickRandom(FLOWER_SHAPES);
			leafShape = pickRandom(LEAF_SHAPES);
			flowerColor = pickRandom(FLOWER_COLORS);
		}
		
		public function get leafShapeIndex():int {
			return LEAF_SHAPES.indexOf(leafShape);
		}
		
		public function get flowerShapeIndex():int {
			return FLOWER_SHAPES.indexOf(flowerShape);
		}
		
		public function get flowerColorMults():Array {
			return FLOWER_COLOR_MULTS[flowerColor];
		}
		
		// Helper
		private function pickRandom(arr:Array):* {
			return arr[Rndm.integer(arr.length)];
		}
		
		public function get description():String {
			if (flowerColor == null && flowerShape == null && leafShape == null) {
				return "Any plant";
			}
			
			var description:String = "A plant with "
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
