package iface.common.time 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IMasterTimeline
	{
		function start():void;
		function stop():void;
		function addTimeline( timeline:ITimeline ):void;
	}
	
}