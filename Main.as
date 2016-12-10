package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	
	
	public class Main extends MovieClip {
		
		var plant:Plant;
		
		public function Main() {
			// constructor code
			stage.quality = StageQuality.LOW;
			
			
			plant = new Plant();
			plant.draw();
			plant.x = stage.stageWidth / 2;
			plant.y = stage.stageHeight / 2;
			addChild(plant);
			
			var textBox:TextBox = new TextBox();
			textBox.text = "Testing font!"
			addChild(textBox);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
				case Keyboard.SPACE:
					plant.draw();
					break;
			}
		}
	}
	
}
