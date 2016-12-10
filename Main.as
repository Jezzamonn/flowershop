package  {
	
	import flash.display.MovieClip;
	
	
	public class Main extends MovieClip {
		
		
		public function Main() {
			// constructor code
			
			var flower:Plant = new Plant();
			flower.draw();
			flower.x = stage.stageWidth / 2;
			flower.y = stage.stageHeight / 2;
			addChild(flower);
		}
	}
	
}
