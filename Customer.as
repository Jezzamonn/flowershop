package  {
	import com.gskinner.utils.Rndm;
	
	public class Customer {
		
		public var plantType:PlantType;

		public function Customer() {
			plantType = new PlantType();
		}
		
		public function randomisePreferences(difficulty:int = 1):void {
			// Select the preferences this person has
			var prefs:Array = [];
			for (var prop:* in PlantType.PROPERTIES) {
				prefs.push(prop);
			}
			
			while (prefs.length > difficulty) {
				var ranIndex:int = Rndm.integer(prefs.length);
				prefs.splice(ranIndex, 1);
			}
			
			for each (var pref in prefs) {
				plantType.randomise(pref);
			}
		}

	}
	
}
