package iface.client.animation 
{
	import iface.common.time.ITickHandler;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IAnimation extends ITickHandler
	{
		function isDone():Boolean;
		function isPaused():Boolean;
		function pause():void;
		function play():void;
		function cancel():void;
		function run():void;
	}
	
}