package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	
	
	public class Main extends MovieClip {
		
		var plant:Plant;
		var textBox:TextBox;
		
		public function Main() {
			// constructor code
			stage.quality = StageQuality.LOW;
			
			
			plant = new Plant();
			plant.draw();
			plant.x = stage.stageWidth / 2;
			plant.y = stage.stageHeight / 2;
			addChild(plant);
			
			textBox = new TextBox();
			textBox.text = "Testing font!"
			textBox.width = stage.stageWidth;
			addChild(textBox);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
				case Keyboard.SPACE:
					if (contains(plant)) {
						removeChild(plant);
					}
					plant = new Plant();
					plant.draw();
					plant.x = stage.stageWidth / 2;
					plant.y = stage.stageHeight / 2;
					addChild(plant);
					
					textBox.text = "A plant with " +
								   plant.color + ", " + plant.flowerShape + " flowers and " +
								   plant.leafShape + " leaves.";
					break;
			}
		}
	}
	
}
