package iface.client.service.timer 
{
	import iface.client.service.video.IRenderer;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITimerHandler 
	{
		function timerTick( millisecondDelta:int, renderer:IRenderer ):void;
	}
	
}