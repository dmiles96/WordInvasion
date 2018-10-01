package iface.client.presentation.level 
{
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ILevelPresentation 
	{
		function getCanvas():ICanvas;
		function start():void;
	}
	
}