package impl.common.scope 
{
	import iface.client.configuration.IApplicationConfiguration;
	import iface.common.scope.ISessionScope;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	import iface.common.scope.ISessionScopeFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SessionScopeFactory implements ISessionScopeFactory
	{
		public function SessionScopeFactory() 
		{
		}
		
		public function createSessionScope(masterTimeline:IMasterTimeline, gameTimeline:IGameTimeline):ISessionScope
		{
			return new SessionScope(masterTimeline, gameTimeline);
		}
	}
	
}