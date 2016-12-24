package  {
	import flash.display.Sprite;
	import com.gskinner.utils.Rndm;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class Plant extends Sprite {
		
		public var plantType:PlantType;
		public var seed:int;
		
		public function Plant() {
			plantType = new PlantType();
			seed = Rndm.integer(int.MAX_VALUE);
		}
		
		public function draw():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			var rndm:Rndm = new Rndm(seed);

			// pot
			var pot:MovieClip = new Pot();
			pot.scaleX = 0.5;
			pot.scaleY = 0.5;
			pot.x = rndm.float(-2, 2);
			pot.y = rndm.float(-2, 2);
			pot.rotation = rndm.float(-2, 2);
			addChild(pot);

			var xAmt1:Number;
			var yAmt1:Number;
			var xAmt2:Number;
			var yAmt2:Number;

			var w:Number = 140;
			var h:Number = 120;

			// leaves
			if (plantType.leafShape) {
				for (var i:int = 0; i < 100; i ++) {
					var leaf:MovieClip = new Leaf();
					
					leaf.gotoAndStop(plantType.leafShapeIndex + 1);
					
					xAmt1 = rndm.random();
					yAmt1 = rndm.random();
					// fold over one part of the square to make a triangle
					if (xAmt1 + yAmt1 < 1) {
						// 0,0 -> 1,1
						// 1,0 -> 1,0
						// 0,1 -> 2,1
						// I think this works. It's like turning that triangle
						yAmt2 = 1 - xAmt1;
						xAmt2 = 1 + yAmt1;
					}
					else {
						xAmt2 = xAmt1;
						yAmt2 = yAmt1;
					}
					// Normalise xAmt;
					xAmt2 /= 2;

					leaf.scaleX = 0.2;
					leaf.scaleY = 0.2;
					leaf.rotation = 180 - 40 * (xAmt2 - 0.5);
					leaf.x = -w/2 + w * xAmt2;
					leaf.y = -50 - h + h * yAmt2;
					
					// All leaves are the same green for the moment
					leaf.transform.colorTransform = new ColorTransform(0.3, 0.6, 0.3);
					addChild(leaf);
				}
			}
			
			// flowers
			if (plantType.flowerShape && plantType.flowerColor) {
				for (var j:int = 0; j < 40; j ++) {
					var flower:MovieClip = new Flower();
					
					flower.gotoAndStop(1);
					
					xAmt1 = rndm.random();
					yAmt1 = rndm.random();
					// fold over one part of the square to make a triangle
					if (xAmt1 + yAmt1 < 1) {
						// 0,0 -> 1,1
						// 1,0 -> 1,0
						// 0,1 -> 2,1
						// I think this works. It's like turning that triangle
						yAmt2 = 1 - xAmt1;
						xAmt2 = 1 + yAmt1;
					}
					else {
						xAmt2 = xAmt1;
						yAmt2 = yAmt1;
					}
					// Normalise xAmt;
					xAmt2 /= 2;

					flower.scaleX = 0.1;
					flower.scaleY = 0.1;
					flower.rotation = rndm.float(360);
					flower.x = -w/2 + w * xAmt2;
					flower.y = -40 - h + h * yAmt2;
					
					addChild(flower);
				}
			}

			randomiseFlowers();
		}

		public function randomiseFlowers():void {
			for (var i:int = 0; i < numChildren; i ++) {
				var child:* = getChildAt(i);
				if (child is Flower) {
					var mults = [0, 1, Rndm.float(1)];
					Util.shuffle(mults);
					child.transform.colorTransform = new ColorTransform(mults[0], mults[1], mults[2]);
				}
			}
		}
	}
	
}
