﻿package  {
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
				bgShape.graphics.beginFill(0xFFFFFF, 0.5);
				bgShape.graphics.drawRoundRect(0, 3, textField.textWidth + 3, textField.textHeight, 16);
			}
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
