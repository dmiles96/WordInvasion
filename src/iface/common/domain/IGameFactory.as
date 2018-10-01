package iface.common.domain 
{
	import iface.common.configuration.IApplicationConfiguration;
	import iface.common.time.ITimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGameFactory 
	{
		function createGame():IGame;
	}
	
}