package  {
	import com.gskinner.utils.Rndm;
	
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

	}
	
}
