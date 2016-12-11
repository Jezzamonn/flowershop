package  {
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TextBox extends TextField {
		
		[Embed(source="m3x6.ttf",
        fontName = "m3x6",
        mimeType = "application/x-font",
        advancedAntiAliasing="true",
        embedAsCFF="false")]
		private static const m5x7:Class;
		
		public var textFormat:TextFormat;

		public function TextBox() {
			// constructor code
			super();
			
			textFormat = new TextFormat("m3x6", 16);
			defaultTextFormat = textFormat;
			wordWrap = true;
			embedFonts = true;
		}

	}
	
}
