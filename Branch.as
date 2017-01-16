package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import com.gskinner.utils.Rndm;
	import flash.geom.ColorTransform;

	public class Branch extends Sprite {

		// because I can't be bothered dealing with the points class, this is just an array of objects
		public var points:Array;
		public var startThicknessIndex:int = 0;

		// Leaves contain the following: a leaf object, and index, representing how far along the branch it is
		public var leaves:Array;

		// for growing
		public var bendyAmount:Number = 1;
		public var angle:Number = -Math.PI / 2;
		public var dAngle:Number = 0;

		public var growing:Boolean = true;
		public var growLength:Number = 0;

		public function get lengthSoFar():int {
			return startThicknessIndex + points.length - 1;
		}

		public function Branch(startX:Number, startY:Number) {
			points = [{x: startX, y: startY}];
			leaves = [];
			growLength = 40;
		}

		public function grow():void {
			if (!growing) {
				return;
			}
			var growSpeed:Number = 2 * Math.exp(-0.01 * lengthSoFar);
			// Squaring this makes thicker branches branch faster
			growLength -= growSpeed * growSpeed * growSpeed;

			// Lengthen the branch
			var lastPoint:Object = points[points.length-1];
			var newPoint:Object = {
				x: lastPoint.x + growSpeed * Math.cos(angle),
				y: lastPoint.y + growSpeed * Math.sin(angle)
			};
			points.push(newPoint);

			// Add a leaf!
			if (Rndm.boolean(0.02 + lengthSoFar / 2000)) {
				var leaf:MovieClip = new Leaf();
				leaf.gotoAndStop(0);
				leaf.rotation = (180 / Math.PI) * angle;
				if (Rndm.boolean()) {
					leaf.rotation += 180;
				}
				leaf.x = newPoint.x;
				leaf.y = newPoint.y;
				leaf.scaleX = 0.1;
				leaf.scaleY = 0.1;
				leaf.transform.colorTransform = new ColorTransform(0.3, 0.6, 0.3);
				addChild(leaf);

				leaves.push([leaf, lengthSoFar])
			}

			// Change the direction of growth
			var maxDAngle:Number = 0.03 * bendyAmount;
			var dAngleChange:Number = 0.03 * bendyAmount;

			dAngle += Rndm.float(-dAngleChange, dAngleChange);
			if (dAngle < -maxDAngle) {
				dAngle = -maxDAngle;
			}
			else if (dAngle > maxDAngle) {
				dAngle = maxDAngle;
			}
			angle += dAngle;

			// TODO (maybe): move the existing points a little?

		}

		public function draw(maxLength:int, totalGrowingAmt:int):void {
			var amt:Number;
			graphics.clear();
			// TODO: Move colours to a nicer place?
			for (var i:int = 1; i < points.length; i ++) {
				// The length from the root to here
				var length:int = startThicknessIndex + i - 1;
				amt = 1 - length / Math.min(maxLength, totalGrowingAmt);
				amt *= amt;
				amt *= Math.min(maxLength, totalGrowingAmt) / totalGrowingAmt;
				graphics.lineStyle(8 * amt + 2, 0x423027);
				graphics.moveTo(points[i-1].x, points[i-1].y);
				graphics.lineTo(points[i].x, points[i].y);
			}

			for each (var leafInfo in leaves) {
				var leaf:MovieClip = leafInfo[0];
				var index:int = leafInfo[1];

				amt = 1 - index / maxLength;
				amt *= maxLength / totalGrowingAmt;
				amt = Math.min(amt, 0.2) * 5;
				leaf.scaleX = 0.12 * amt;
				leaf.scaleY = 0.12 * amt;
			}
		}

		// stops growing and creates two child branches
		public function split():Array {
			var lastPoint:Object = points[points.length-1];
			var childBranches:Array = [];

			for (var i:int = 0; i < 2; i ++) {
				var child:Branch = new Branch(lastPoint.x, lastPoint.y);
				child.bendyAmount = this.bendyAmount * 1.3;
				child.angle = this.angle;
				child.startThicknessIndex = lengthSoFar;
				childBranches.push(child);
			}
			// make the angles different
			childBranches[0].angle -= 0.5;
			childBranches[1].angle += 0.5;

			growing = false;

			return childBranches;
		}

	}

}