package  {
	import flash.display.Sprite;
	import com.gskinner.utils.Rndm;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	public class Plant extends Sprite {
		
		public var plantType:PlantType;
		public var seed:int;

		public var branches:Array;
		public var behindBranchSprite:Sprite;
		public var inFrontBranchSprite:Sprite;
		public var growLength:int = 0;
		public var totalGrowingAmount:int = 120
		
		public function Plant() {
			plantType = new PlantType();
			seed = Rndm.integer(int.MAX_VALUE);

			behindBranchSprite = new Sprite();
			inFrontBranchSprite = new Sprite();

			branches = [];
			branches.push(new Branch(0, 0));
			behindBranchSprite.addChild(branches[0]);
		}
		
		public function draw():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
			
			var rndm:Rndm = new Rndm(seed);

			// pot
			var pot:MovieClip = new Pot();
			pot.scaleX = 0.7;
			pot.scaleY = 0.7;
			pot.x = rndm.float(-2, 2);
			pot.y = rndm.float(-2, 2);
			pot.rotation = rndm.float(-2, 2);

			// Get the position that the plant should grow from
			var branchPoint:Point = new Point(-2, -85);
			branchPoint = pot.localToGlobal(branchPoint);

			// Add the sprite for branches behind the pot
			behindBranchSprite.x = branchPoint.x;
			behindBranchSprite.y = branchPoint.y;
			addChild(behindBranchSprite);

			addChild(pot);

			// leaves
			if (plantType.leafShape) {
				for (var i:int = 0; i < 40; i ++) {
					var leaf:MovieClip = new Leaf();
					
					leaf.gotoAndStop(plantType.leafShapeIndex + 1);
					
					leaf.scaleX = 0.3;
					leaf.scaleY = 0.3;
					leaf.rotation = 180 + rndm.float(-60, 60);
					leaf.x = rndm.float(-50, 50);
					leaf.y = rndm.float(-170, -70);
					
					// All leaves are the same green for the moment
					leaf.transform.colorTransform = new ColorTransform(0.3, 0.6, 0.3);
					leaf.alpha = 0.1;
					addChild(leaf);
				}
			}
			
			// flowers
			if (plantType.flowerShape && plantType.flowerColor) {
				for (var j:int = 0; j < 8; j ++) {
					var flower:MovieClip = new Flower();
					
					flower.gotoAndStop(plantType.flowerShapeIndex + 1);
					
					flower.scaleX = 0.3;
					flower.scaleY = 0.3;
					flower.rotation = rndm.float(-20, 20);
					flower.x = rndm.float(-40, 40);
					flower.y = rndm.float(-170, -90);
					
					var mults:Array = plantType.flowerColorMults;
					flower.transform.colorTransform = new ColorTransform(mults[0], mults[1], mults[2]);
					flower.alpha = 0.1;
					addChild(flower);
				}
			}

			// All the other branches go here because they should be in front of the pot
			inFrontBranchSprite.x = branchPoint.x;
			inFrontBranchSprite.y = branchPoint.y;
			addChild(inFrontBranchSprite);
		}

		public function growBranches():void {
			growLength ++;
			if (growLength < totalGrowingAmount) {
				// branches
				var newBranches:Array = [];
				for each (var branch:* in branches) {
					branch.grow();

					if (branch.growing && branch.growLength < 0) {
						if (branches.length > 100) {
							//branch.growing = false;
						}
						else {
							var childBranches:Array = branch.split();
							for each (var childBranch:* in childBranches) {
								newBranches.push(childBranch);
							}
						}
					}
				}
			}
			for each (branch in branches) {
				branch.draw(growLength, totalGrowingAmount);
			}

			for each (var newBranch:* in newBranches) {
				branches.push(newBranch);
				inFrontBranchSprite.addChild(newBranch);
			}

		}

	}
	
}
