package  {
	
	public class FlowerBranch {
		
		public var points:Array;

		public var x:Number = 0;
		public var y:Number = 0;
		public var angle:Number = Math.PI;
		public var startWidth:Number = 10;

		public function Flower() {
			// constructor code
			points = [];
		}

		public function grow():void {
			var growAmt:Number = 10;
			x += growAmt * Math.cos(angle);
			y += growAmt * Math.sin(angle);

			points.push(new Point(x, y))

			// TODO: Make the angle wiggle or something.
		}

		public function draw():void {
			for (var i:int = 0; i < points.length; i ++) {
				points.draw();
			}
		}

	}
	
}
