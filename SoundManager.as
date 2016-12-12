package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	
	public class SoundManager {
		
		[Embed(source="music/flowershop.mp3")]
		private static const SONG_CLASS:Class;
		
		private static var song:Sound;
		private static var soundChannel:SoundChannel;

		public static function playSong():void {
			song = new SONG_CLASS() as Sound;
			
			soundChannel = song.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private static function onSoundComplete(evt:Event):void {
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			soundChannel = song.play(8392, int.MAX_VALUE);
		}

	}
	
}
