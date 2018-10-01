package iface.client.view.components 
{
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IDialog 
	{
		function show( parentDrawingSurface:ICanvas ):void;
		function close():void;
	}
	
}