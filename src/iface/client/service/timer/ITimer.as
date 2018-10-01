package iface.client.service.timer 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITimer 
	{
		function start(millisecondsPerTick:int, timerTickHandler:ITimerHandler):void;
		function stop():void;
	}
	
}