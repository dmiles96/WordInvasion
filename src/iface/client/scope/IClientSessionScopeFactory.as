package iface.client.scope 
{
	import iface.client.view.IView;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IClientSessionScopeFactory
	{
		function createSessionScope(gameView:IView, masterTimeline:IMasterTimeline, gameTimeline:IGameTimeline):IClientSessionScope;
	}
	
}