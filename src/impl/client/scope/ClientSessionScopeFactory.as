package impl.client.scope 
{
	import iface.client.scope.IClientSessionScope;
	import iface.client.scope.IClientSessionScopeFactory;
	import iface.client.view.IView;
	import iface.common.scope.ISessionScopeFactory;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ClientSessionScopeFactory implements IClientSessionScopeFactory
	{
		private var sessionScopeFactory:ISessionScopeFactory = null;
		
		public function ClientSessionScopeFactory(sessionScopeFactory:ISessionScopeFactory) 
		{
			this.sessionScopeFactory = sessionScopeFactory;
		}
		
		public function createSessionScope(gameView:IView, masterTimeline:IMasterTimeline, gameTimeline:IGameTimeline):IClientSessionScope
		{
			return new ClientSessionScope( this.sessionScopeFactory.createSessionScope(masterTimeline, gameTimeline), gameView );
		}
		
	}
	
}