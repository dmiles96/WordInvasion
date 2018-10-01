package impl.client.scope 
{
	import iface.client.scope.IClientSessionScope;
	import iface.client.view.IView;
	import iface.common.scope.ISessionScope;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ClientSessionScope implements IClientSessionScope
	{
		private var gameSession:ISessionScope = null;
		private var gameView:IView = null;
		
		public function ClientSessionScope(gameSession:ISessionScope, gameView:IView) 
		{
			this.gameSession = gameSession;
			this.gameView = gameView;
		}
		
		public function getGameTimeline():IGameTimeline
		{
			return this.gameSession.getGameTimeline();
		}
		
		public function getMasterTimeline():IMasterTimeline
		{
			return this.gameSession.getMasterTimeline();
		}		
		
		public function getGameView():IView
		{
			return this.gameView;
		}
	}
	
}