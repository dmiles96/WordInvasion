package impl.common.workflow 
{
	import iface.common.scope.ISessionScope;
	import iface.common.workflow.IWorkflowEngine;
	
	/**
	 * ...
	 * @author ...
	 */
	public class WorkflowEngine
	{
		private var curSessionScope:ISessionScope = null;
		
		public function WorkflowEngine() 
		{
			
		}

		public function registerSession( sessionScope:ISessionScope ):void
		{
			this.curSessionScope = sessionScope;
		}
		
		public function getSession():ISessionScope
		{
			return this.curSessionScope;
		}
		
		public function unregisterGameSession( curSessionScope:ISessionScope ):void
		{
			this.curSessionScope = null;
		}
	}
	
}