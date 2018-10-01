package iface.client.workflow 
{
	import iface.client.scope.IClientSessionScope;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IEndGameWorkflow 
	{
		function endGame(sessionScope:IClientSessionScope):void;
	}
	
}