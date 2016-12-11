package  {
	import com.gskinner.utils.Rndm;
	
	public class Customer {
		
		public var plantType:PlantType;

		public function Customer() {
			plantType = new PlantType();
		}
		
		public function randomisePreferences(difficulty:int = 1):void {
			// Select the preferences this person has
			var prefs:Array = PlantType.PROPERTIES.concat();
			while (prefs.length > difficulty) {
				var ranIndex:int = Rndm.integer(prefs.length);
				prefs.splice(ranIndex, 1);
			}
			// The idea here is to randomise the plant properties,
			// and then set the ones without preferences to null
			plantType.randomise();
			
			// Loop through
			for each (var pref in PlantType.PROPERTIES) {
				// If the preference isn't in the desired preferences
				if (prefs.indexOf(pref) < 0) {
					// Set it to null (i.e. they don't care)
					plantType[pref] = null;
				}
			}
		}

	}
	
}
