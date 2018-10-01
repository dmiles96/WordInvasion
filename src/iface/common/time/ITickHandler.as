package iface.common.time
{
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITickHandler 
	{
		function tick( tickDelta:int ):void;
	}
	
}