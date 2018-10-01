package iface.client.service.audio 
{

	/**
	 * ...
	 * @author ...
	 */
	public interface ISoundMixer extends ISoundPlayer
	{
		function stopAll():void;
		function pauseAll():void;
		function playAll():void;
		function increaseVolume( volumeDelta:Number = .1 ):Number;	
		function decreaseVolume( volumeDelta:Number = -.1 ):Number;
		function getVolume():Number;
	}
	
}