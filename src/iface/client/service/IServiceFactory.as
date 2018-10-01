package iface.client.service 
{
	import iface.client.service.audio.ISoundFactory;
	import iface.client.service.input.IKeyboardHandler;
	import iface.client.service.timer.ITimer;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.service.video.IRenderer;
	import iface.client.service.video.IRenderFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IServiceFactory
	{
		function getCanvasFactory():ICanvasFactory;
		function createTimer():ITimer;
		function getKeyboardHandler():IKeyboardHandler;
		function getRenderFactory():IRenderFactory;
		function getSoundFactory():ISoundFactory;
	}
	
}