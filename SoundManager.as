package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	public class SoundManager {
		
		[Embed(source="music/flowershop.mp3")]
		private static const SONG_CLASS:Class;
		
		[Embed(source="music/a.mp3")]
		private static const A_CLASS:Class;		
		[Embed(source="music/b.mp3")]
		private static const B_CLASS:Class;		
		[Embed(source="music/c.mp3")]
		private static const C_CLASS:Class;		
		[Embed(source="music/d.mp3")]
		private static const D_CLASS:Class;		
		[Embed(source="music/e.mp3")]
		private static const E_CLASS:Class;		
		[Embed(source="music/f.mp3")]
		private static const F_CLASS:Class;		
		[Embed(source="music/g.mp3")]
		private static const G_CLASS:Class;
		
		private static var notes:Array;
		
		public static function init():void {
			notes = [];
			for each (var letter:* in ["a", "b", "c", "d", "e", "f", "g"]) {
				var clss:Class = SoundManager[letter.toUpperCase() + "_CLASS"];
				var note:Sound = new clss() as Sound;
				notes.push(note);
			}
		}
		
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
		
		public static function playSound():void {
			var sound:Sound = Util.pickRandom(notes);
			sound.play(0, 0, new SoundTransform(4));
		}

	}
	
}
