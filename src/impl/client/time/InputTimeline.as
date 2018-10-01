package impl.client.time 
{
	import iface.client.service.input.IKeyboardHandler;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.time.ITimeline;
	import impl.common.time.Timeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class InputTimeline extends Timeline implements ITimeline
	{
		private var keyboardHandler:IKeyboardHandler = null;
		private var workflowEngine:IWorkflowEngine = null;
		
		public function InputTimeline(keyboardHandler:IKeyboardHandler, workflowEngine:IWorkflowEngine, keyboardPollsPerSecond:int) 
		{
			super(keyboardPollsPerSecond);
			
			this.keyboardHandler = keyboardHandler;
			this.workflowEngine = workflowEngine;
		}
		
		public override function tick( tickDelta:int ):void
		{
			workflowEngine.executeProcessInputWorkflow(	keyboardHandler.getKeyStates() );
		}
	}
	
}