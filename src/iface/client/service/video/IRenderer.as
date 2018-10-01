package iface.client.service.video 
{
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IRenderer 
	{
		function renderStart(timerEvent:TimerEvent):void;
		function render():void;
		function renderEnd():void;
		function addUpdateRegion( updateRegion:IUpdateRegion ):void;
	}
	
}