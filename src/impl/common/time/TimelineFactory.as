package impl.common.time 
{

	import iface.client.presentation.IGamePresentation;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.configuration.IApplicationConfiguration;
	import iface.common.domain.IGame;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	import iface.common.time.ITimeline;
	import iface.common.time.ITimelineFactory;
	import iface.common.time.ITimelineTickRecord;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TimelineFactory implements ITimelineFactory
	{
		private var appConfig:IApplicationConfiguration = null;
		
		public function TimelineFactory(appConfig:IApplicationConfiguration ) 
		{
			this.appConfig = appConfig;
		}
		
		public function createMasterTimeline():IMasterTimeline {  /* abstract */ return null; }
		
		public function createGameTimeline(game:IGame, workflowEngine:IWorkflowEngine):IGameTimeline
		{
			return new GameTimeline( appConfig.getGameUpdatesPerSecond(), game, workflowEngine);
		}
		
		public function createTimelineTickRecord( tickDelay:int, timeline:ITimeline ):ITimelineTickRecord
		{
			return new TimelineTickRecord( tickDelay, timeline );
		}
	
	}
	
}