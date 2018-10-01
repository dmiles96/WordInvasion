package iface.common.workflow 
{
	import iface.common.scope.ISessionScope;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IWorkflowEngine 
	{
		function registerSession( sessionScope:ISessionScope ):void;
		function unregisterGameSession( curSessionScope:ISessionScope ):void;
		function executeStartGameWorkflow():void;
		function executeEndGameWorkflow():void;		
	}
	
}