package iface.client.presentation.powerup 
{
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPowerUpPresentation 
	{
		function getCanvas():ICanvas;
		function playSound():void;
	}
	
}