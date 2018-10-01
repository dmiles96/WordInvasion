package iface.client.service.audio 
{
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISoundFactory 
	{
		function createGameSoundFromSound( sound:Sound ):IGameSound;
		function getSoundMixer():ISoundMixer;
	}
	
}