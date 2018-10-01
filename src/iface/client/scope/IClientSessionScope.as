package iface.client.scope 
{
	import iface.client.view.IView;
	import iface.common.scope.ISessionScope;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IClientSessionScope extends ISessionScope
	{
		function getGameView():IView;
	}
	
}