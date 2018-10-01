package iface.client.time 
{
	import iface.client.presentation.IGamePresentation;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.time.ITimeline;
		
	/**
	 * ...
	 * @author ...
	 */
	public interface ITimelineFactory extends iface.common.time.ITimelineFactory
	{
		function createAnimationTimeline():IAnimationTimeline;
		function createInputTimeline(workflowEngine:IWorkflowEngine):ITimeline;
	}
	
}