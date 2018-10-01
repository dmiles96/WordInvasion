package iface.client.service.audio 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISoundPlayer 
	{
		function playSound( sound:Sound, startTime:Number = 0, loops:int = 0 ):SoundChannel;
	}
	
}