package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.StageQuality;
	
	
	public class Main extends MovieClip {
		
		public static const WIDTH:int = 550;
		public static const HEIGHT:int = 550;
		
		var plant:Plant;
		var textBox:TextBox;
		var customers:Array;
		
		public function Main() {
			// constructor code
			stage.quality = StageQuality.LOW;
			
			textBox = new TextBox();
			textBox.width = stage.stageWidth;
			addChild(textBox);
			
			var workBench:Workbench = new Workbench();
			addChild(workBench);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function startDay():void {
			customers = [];
		}
		
		public function onKeyDown(evt:KeyboardEvent):void {
			switch (evt.keyCode) {
			}
		}
	}
	
}
