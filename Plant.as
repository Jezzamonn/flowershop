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
			branches.push(new Branch(this, 0, 0));
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
			else if (growLength == totalGrowingAmount) {
				for each (branch in branches) {
					if (branch.growing && Rndm.boolean(0.5)) {
						branch.addFlower();
					}
				}
			}

			for each (var newBranch:* in newBranches) {
				branches.push(newBranch);
				inFrontBranchSprite.addChild(newBranch);
			}
		}

		public function fullyGrow():void {
			while (growLength < totalGrowingAmount) {
				growBranches();
			}
			growLength += 100;
		}

		public function drawBranches():void {
			for each (var branch:* in branches) {
				branch.draw(growLength, totalGrowingAmount);
			}
		}

	}
	
}
