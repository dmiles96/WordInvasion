package iface.common.time 
{
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.IGame;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITimelineFactory 
	{
		function createMasterTimeline():IMasterTimeline;
		function createGameTimeline(game:IGame, workflowEngine:IWorkflowEngine):IGameTimeline;
		function createTimelineTickRecord( tickDelay:int, timeline:ITimeline ):ITimelineTickRecord;
	}
	
}