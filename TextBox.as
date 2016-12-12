package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.Shape;
	
	public class TextBox extends Sprite {
		
		[Embed(source="m3x6.ttf",
        fontName = "m3x6",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const m5x7:Class;
		
		public var textField:TextField;
		public var textFormat:TextFormat;
		public var bgShape:Shape;

		public function TextBox() {
			// constructor code
			super();
			
			bgShape = new Shape();
			addChild(bgShape);
			
			textFormat = new TextFormat("m3x6", 16);
			textField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.wordWrap = true;
			textField.embedFonts = true;
			
			addChild(textField);
		}
		
		public function updateBGShape():void {
			bgShape.graphics.clear();
			if (textField.text.length > 0) {
				bgShape.graphics.beginFill(0xFFFFFF);
				bgShape.graphics.drawRoundRect(0, 3, textField.textWidth + 3, textField.textHeight, 16);
				bgShape.alpha = 0.5;
			}
		}
		
		public function get minX():Number {
			return this.x;
		}
		
		public function set minX(val:Number):void {
			this.x = val;
		}
		
		public function get maxX():Number {
			return minX + textField.textWidth + 3 
		}
		
		public function set maxX(val:Number) {
			minX = val - textField.textWidth - 3;
		}
		
		public function get minY():Number {
			return this.y + 3;
		}
		
		public function set minY(val:Number):void {
			this.y = val - 3;
		}
		
		public function get maxY():Number {
			return minY + textField.textHeight;
		}
		
		public function set maxY(val:Number):void {
			minY = val - textField.textHeight;
		}
		
		public function get text():String {
			return textField.text;
		}
		
		public function set text(val:String):void {
			textField.text = val;
			updateBGShape();
		}

	}
	
}
