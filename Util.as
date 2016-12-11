package  {
	import com.gskinner.utils.Rndm;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	
	public class Util {

		public static function pickRandom(arr:Array):* {
			return arr[Rndm.integer(arr.length)];
		}
		
		// For lazy shuffling. Thanks stack overflow
		// http://stackoverflow.com/questions/11980657/as3-random-array-randomize-array-actionscript-3
		public static function randomCompare(a:*, b:*):int {
			return Rndm.sign();
		}
		
		public static function shuffle(arr:Array) {
			arr.sort(randomCompare);
		}
		
		public static function getCloseChild(parent:DisplayObjectContainer, mouseX:Number, mouseY:Number, radius:Number = 10):DisplayObject {
			for (var i:int = 0; i < parent.numChildren; i ++) {
				var child:DisplayObject = parent.getChildAt(i);
				var xDif:Number = parent.x + child.x - mouseX;
				var yDif:Number = parent.y + child.y - mouseY;
				var r2Dif = xDif * xDif + yDif * yDif;
				
				if (r2Dif < radius * radius) {
					return child;
				}
			}
			return null;
		}

	}
	
}
