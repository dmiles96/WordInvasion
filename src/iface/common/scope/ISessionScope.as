package iface.common.scope 
{
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISessionScope 
	{
		function getGameTimeline():IGameTimeline;
		function getMasterTimeline():IMasterTimeline;
	}
	
}