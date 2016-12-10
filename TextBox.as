package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TextBox extends TextField {
		
		[Embed(source="m5x7.ttf",
        fontName = "m5x7",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const m5x7:Class;
		
		public var textFormat:TextFormat;

		public function TextBox() {
			// constructor code
			super();
			
			textFormat = new TextFormat("m5x7", 32);
			defaultTextFormat = textFormat;
			wordWrap = true;
			embedFonts = true;
		}

	}
	
}
