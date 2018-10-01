package impl.client.service.audio 
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.audio.ISoundFactory;
	import iface.client.service.audio.ISoundMixer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SoundFactory implements ISoundFactory
	{
		private var soundMixer:ISoundMixer = null;
		
		public function SoundFactory(globalSoundTransform:SoundTransform) 
		{
			this.soundMixer = new SoundMixer(globalSoundTransform);
		}
		
		public function createGameSoundFromSound( sound:Sound ):IGameSound
		{
			return new GameSound( sound, soundMixer );
		}
		
		public function getSoundMixer():ISoundMixer
		{
			return this.soundMixer;
		}
	}
	
}