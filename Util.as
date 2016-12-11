package  {
	import com.gskinner.utils.Rndm;
	
	public class Util {

		public static function pickRandom(arr:Array):* {
			return arr[Rndm.integer(arr.length)];
		}

	}
	
}
