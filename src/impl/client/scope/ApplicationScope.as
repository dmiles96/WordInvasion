package impl.client.scope 
{
	import iface.client.workflow.IWorkflowEngine;
	import iface.client.configuration.IApplicationConfiguration;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ApplicationScope
	{
		private var workflowEngine:IWorkflowEngine;
		private var applicationConfiguration:IApplicationConfiguration
		
		public function ApplicationScope(applicationConfiguration:IApplicationConfiguration, workflowEngine:IWorkflowEngine) 
		{
			this.applicationConfiguration = applicationConfiguration;
			this.workflowEngine = workflowEngine;
		}
		
		public function getWorfklowEngine():IWorkflowEngine
		{
			return this.workflowEngine;
		}
		
		public function getApplicationConfiguration():IApplicationConfiguration
		{
			return this.applicationConfiguration;
		}
		
	}
	
}