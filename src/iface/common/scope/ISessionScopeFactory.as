package iface.common.scope 
{
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ISessionScopeFactory 
	{
		function createSessionScope(masterTimeline:IMasterTimeline, gameTimeline:IGameTimeline):ISessionScope;
	}
	
}