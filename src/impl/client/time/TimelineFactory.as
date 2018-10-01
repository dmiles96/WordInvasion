package impl.client.time 
{
	import iface.client.animation.IAnimationEngine;
	import iface.client.presentation.IGamePresentation;
	import iface.client.service.IServiceFactory;
	import iface.client.time.IAnimationTimeline;
	import iface.client.time.ITimelineFactory;
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.IGame;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	import iface.common.time.ITimeline;
	import impl.client.animation.AnimationEngine;
	import impl.common.time.TimelineFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TimelineFactory extends impl.common.time.TimelineFactory implements iface.client.time.ITimelineFactory
	{
		private var appConfig:IApplicationConfiguration = null;
		private var serviceFactory:IServiceFactory = null;
		private var animationEngine:IAnimationEngine = null;
		private var workflowEngine:IWorkflowEngine = null;
		
		public function TimelineFactory(appConfig:IApplicationConfiguration, serviceFactory:IServiceFactory, animationEngine:IAnimationEngine) 
		{	
			super(appConfig);
			
			this.appConfig = appConfig;
			this.serviceFactory = serviceFactory;
			this.animationEngine = animationEngine;
		}
		
		public function createAnimationTimeline():IAnimationTimeline
		{
			return new AnimationTimeline(appConfig.getAnimationFramesPerSecond(), animationEngine);
		}
		
		public override function createMasterTimeline():IMasterTimeline
		{
			return new MasterTimeline(this, serviceFactory.createTimer(), appConfig.getMillisecondsPerTick());
		}
		
		public function createInputTimeline(workflowEngine:IWorkflowEngine):ITimeline
		{
			return new InputTimeline(serviceFactory.getKeyboardHandler(), workflowEngine, appConfig.getKeyboardPollsPerSecond());
		}
	}
	
}