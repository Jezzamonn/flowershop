package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	
	
	public class Main extends MovieClip {
		
		var plant:Plant;
		var textBox:TextBox;
		var customers:Array;
		
		public function Main() {
			// constructor code
			stage.quality = StageQuality.LOW;
			
			textBox = new TextBox();
			textBox.width = stage.stageWidth;
			addChild(textBox);
			
			randomise();
			
			startDay();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function startDay():void {
			customers = [];
			for (var i:int = 0; i < 10; i ++) {
				var customer:Customer = new Customer();
				customer.randomisePreferences(i % 4);
				trace(customer.plantType.description);
			}
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
				case Keyboard.SPACE:
					randomise();
					break;
			}
		}
		
		public function randomise():void {
			if (plant != null && contains(plant)) {
				removeChild(plant);
			}
			plant = new Plant();
			plant.plantType.randomise();
			plant.draw();
			plant.x = stage.stageWidth / 2;
			plant.y = stage.stageHeight / 2 + plant.height / 2;
			addChild(plant);
			
			textBox.text = plant.plantType.description;
		}
	}
	
}
