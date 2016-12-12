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
		
		private static var noteSounds:Object;
		
		public static function init():void {
			noteSounds = {};
			for each (var letter:* in ["a", "b", "c", "d", "e", "f", "g"]) {
				var clss:Class = SoundManager[letter.toUpperCase() + "_CLASS"];
				var note:Sound = new clss() as Sound;
				noteSounds[letter] = note;
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
			var notes:Array;
			switch (currentChord) {
				case "C":
				default:
					notes = ["c", "e", "g"];
					break;
				case "F":
					notes = ["c", "f", "a"];
					break;
				case "G":
					notes = ["d", "g", "b"];
					break;
				case "Am":
					notes = ["c", "e", "a"];
					break;
			}
			var note:String = Util.pickRandom(notes);
			var sound:Sound = noteSounds[note];
			sound.play(0, 0, new SoundTransform(4));
		}
		
		public static function get currentChord():String {
			// Gosh this took a while to do and probably wasn't worth it
			var chordStarts:Object = {
				0: "C",
				16280: "F",
				24330: "C",
				31949: "F",
				39676: "G",
				45174: "C",
				48229: "Am",
				51140: "C",
				54033: "Am",
				56890: "F",
				59909: "G",
				(60000 + 2676): "C",
				(60000 + 11248): "Am",
				(60000 + 13889): "C",
				(60000 + 16782): "Am",
				(60000 + 19621): "F",
				(60000 + 22317): "G",
				(60000 + 25030): "C",
				(60000 + 33296): "Am",
				(60000 + 35991): "C",
				(60000 + 38920): "Am",
				(60000 + 41526): "F",
				(60000 + 44239): "G",
				(60000 + 46952): "C",
				(60000 + 55236): "Am",
				(60000 + 57950): "C",
				(120000 + 699): "Am",
				(120000 + 3448): "F",
				(120000 + 6126): "G",
				(120000 + 8803): "C"
			};
			var chordStartPositions:Array = [];
			for (var key:* in chordStarts) {
				chordStartPositions.push(int(key));
			}
			chordStartPositions.sort(Array.NUMERIC);
			
			var chordIndex:int = 0;
			for (var i:int = 0; i < chordStartPositions.length; i ++) {
				if (soundChannel.position > chordStartPositions[i]) {
					chordIndex = i;
				}
				else {
					break;
				}
			}
			
			return chordStarts[chordStartPositions[chordIndex]];
		}

	}
	
}
