package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	
	
	public class Main extends MovieClip {
		
		public static const WIDTH:int = 550;
		public static const HEIGHT:int = 550;
		
		var textBox:TextBox;
		var customers:Array;
		var workbench:Workbench;
		
		public function Main() {
			// constructor code
			stage.quality = StageQuality.LOW;
			
			textBox = new TextBox();
			textBox.width = stage.stageWidth;
			addChild(textBox);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function startDay():void {
			customers = [];
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
				case Keyboard.SPACE:
					if (workbench == null) {
						workbench = new Workbench();
						addChild(workbench);
					}
					else {
						workbench.state ++;
						if (workbench.state >= 4) {
							removeChild(workbench);
							workbench = null;
						}
						else {
							workbench.updateState();
						}
					}
					break;
			}
		}
	}
	
}
