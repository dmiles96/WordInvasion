package iface.client.workflow 
{
	import iface.client.scope.IClientSessionScope;
	import iface.client.view.IContinueHandler;
	import iface.common.scope.ISessionScope;
	import iface.common.workflow.IStartGameWorkflow;
	import iface.common.workflow.IWorkflowEngine;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IWorkflowEngine extends iface.common.workflow.IWorkflowEngine
	{
		function executeRunGameWorkflow():void;
		function executeProcessInputWorkflow( keyStates:Object ):void;
		function executeShowHighscoreWorkflow( enterName:Boolean, onContinueHandler:IContinueHandler, score:int = 0 ):void;
		function getClientSession():IClientSessionScope;
	}
	
}