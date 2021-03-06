﻿package  {
	
	public class FactorMapping {

		public var factorMapping:Object;
		public var shuffledProperties:Object;
		
		public function FactorMapping() {
			// This part makes seed type randomly influence flower shape or color, etc.
			factorMapping = {};
			
			// Put the options in arrays
			var factors:Array = [];
			var properties:Array = [];
			for (var factor:* in PlantType.FACTORS) {
				factors.push(factor);
			}
			for (var prop:* in PlantType.PROPERTIES) {
				properties.push(prop);
			}
			Util.shuffle(properties);
			
			// now we just map them 1 to one
			for (var i:int = 0; i < factors.length; i ++) {
				factorMapping[factors[i]] = properties[i];
			}
			
			// This part makes a specific option (e.g. little water) have a random result
			// So if water influenced color, the same water would have a different result
			shuffledProperties = {};
			for (prop in PlantType.PROPERTIES) {
				shuffledProperties[prop] = PlantType.PROPERTIES[prop].concat();
				Util.shuffle(shuffledProperties[prop]);
			}
		}
		
		public function createFromFactors(seedType:String, fertilizer:String, waterAmount:String):PlantType {
			// This makes the next part easier
			var factors:Object = {
				"seedType": seedType,
				"fertilizer": fertilizer,
				"waterAmount": waterAmount
			}
			
			var plantType:PlantType = new PlantType();
			
			// This is a bit confusing. Sorry!
			for (var factorName in factors) {
				var factorValue:String = factors[factorName];
				var index:int = PlantType.FACTORS[factorName].indexOf(factorValue);
				
				// Thie corresponding property
				var property:String = factorMapping[factorName];
				plantType[property] = shuffledProperties[property][index];
			}
			
			return plantType;
		}

	}
	
}
