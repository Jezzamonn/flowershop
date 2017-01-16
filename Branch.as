package  {
	import flash.display.Sprite;
	import com.gskinner.utils.Rndm;
	
	public class Branch extends Sprite {

		// because I can't be bothered dealing with the points class, this is just an array of objects
		public var points:Array;
		public var startThicknessIndex:int = 0;

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
			graphics.clear();
			// TODO: Move colours to a nicer place?
			graphics.lineStyle(10 * (maxLength - startThicknessIndex) / totalGrowingAmt, 0x2e5e3a)
			graphics.moveTo(points[0].x, points[0].y);
			for (var i:int = 1; i < points.length; i ++) {
				graphics.lineTo(points[i].x, points[i].y);
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