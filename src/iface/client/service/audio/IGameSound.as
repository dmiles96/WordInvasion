package iface.client.service.audio 
{
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGameSound 
	{
		function play(startTime:Number = 0, loops:int = 0):SoundChannel;
		function getLength():Number;
	}
	
}