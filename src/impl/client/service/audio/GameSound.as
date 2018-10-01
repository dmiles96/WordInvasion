package impl.client.service.audio 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.audio.ISoundPlayer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameSound implements IGameSound
	{
		private var sound:Sound = null;
		private var soundPlayer:ISoundPlayer = null;
		
		public function GameSound( sound:Sound, soundPlayer:ISoundPlayer ) 
		{
			this.sound = sound;
			this.soundPlayer = soundPlayer;
		}
		
		public function play(startTime:Number = 0, loops:int = 0):SoundChannel
		{
			return this.soundPlayer.playSound(sound, startTime, loops);
		}
		
		public function getLength():Number
		{
			return this.sound.length;
		}
	}
	
}