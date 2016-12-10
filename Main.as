package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	public class Main extends MovieClip {
		
		var plant:Plant;
		
		
		public function Main() {
			// constructor code
			
			plant = new Plant();
			plant.draw();
			plant.x = stage.stageWidth / 2;
			plant.y = stage.stageHeight / 2;
			addChild(plant);
			
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
