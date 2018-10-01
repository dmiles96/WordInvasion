package iface.client.view 
{
	import iface.client.service.video.IUpdateRegion;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGameView extends IView
	{
		function getUpdateRegion():IUpdateRegion;
	}
	
}