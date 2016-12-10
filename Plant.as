package  {
	import flash.display.Sprite;
	import com.gskinner.utils.Rndm;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class Plant extends Sprite {
		
		public var flowerShape:String;
		public var leafShape:String;
		public var color:String;

		public function Plant() {
			// constructor code
		}
		
		public function draw():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			var leafType:int = Rndm.integer((new Leaf()).totalFrames);
			var flowerType:int = Rndm.integer((new Flower()).totalFrames);
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
				
				flower.transform.colorTransform = new ColorTransform(0.7, 0.3, 0.3);
				addChild(flower);
			}
		}

	}
	
}
