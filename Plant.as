package  {
	import flash.display.Sprite;
	import com.gskinner.utils.Rndm;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class Plant extends Sprite {
		
		public static const FLOWER_SHAPES:Array = [
			"rose", "sketchy", "tissue box",
		];
		public static const LEAF_SHAPES:Array = [
			"smooth", "jagged", "spikey",
		];
		public static const COLORS:Array = [
			"red", "pink", "blue", "orange", "purple",
		];
		public static const COLOR_MULTS:Object = {
			red: [0.7, 0.3, 0.3],
			pink: [0.8, 0.6, 0.6],
			blue: [0.3, 0.4, 0.6],
			orange: [0.7, 0.5, 0.3],
			purple: [0.6, 0.4, 0.6]
		};
		
		public var flowerShape:String;
		public var leafShape:String;
		public var color:String;

		public function Plant() {
			// constructor code
			flowerShape = pickRandom(FLOWER_SHAPES);
			leafShape = pickRandom(LEAF_SHAPES);
			color = pickRandom(COLORS);
		}
		
		private function pickRandom(arr:Array):* {
			return arr[Rndm.integer(arr.length)];
		}
		
		public function draw():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			var leafType:int = LEAF_SHAPES.indexOf(leafShape);
			var flowerType:int = FLOWER_SHAPES.indexOf(flowerShape);
			
			// leaves
			for (var i:int = 0; i < 40; i ++) {
				var leaf:MovieClip = new Leaf();
				
				leaf.gotoAndStop(leafType + 1);
				
				leaf.scaleX = 0.3;
				leaf.scaleY = 0.3;
				leaf.rotation = 180 + Rndm.float(-60, 60);
				leaf.x = Rndm.float(-50, 50);
				leaf.y = Rndm.float(-50, 50);
				
				leaf.transform.colorTransform = new ColorTransform(0.3, 0.6, 0.3);
				addChild(leaf);
			}
			
			// flowers
			for (var j:int = 0; j < 8; j ++) {
				var flower:MovieClip = new Flower();
				
				flower.gotoAndStop(flowerType + 1);
				
				flower.scaleX = 0.3;
				flower.scaleY = 0.3;
				flower.rotation = Rndm.float(-20, 20);
				flower.x = Rndm.float(-40, 40);
				flower.y = Rndm.float(-50, 40);
				
				var mults:Array = COLOR_MULTS[color];
				flower.transform.colorTransform = new ColorTransform(mults[0], mults[1], mults[2]);
				addChild(flower);
			}
		}

	}
	
}
