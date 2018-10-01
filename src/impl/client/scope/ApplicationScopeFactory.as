package impl.client.scope 
{
	import flash.display.Sprite;
	import flash.media.SoundTransform;
	import iface.client.animation.IAnimationEngine;
	import iface.client.presentation.highscore.IHighscorePresentationManagerFactory;
	import iface.client.presentation.IGamePresentationFactory;
	import iface.client.scope.IClientSessionScopeFactory;
	import iface.client.service.audio.ISoundFactory;
	import iface.client.service.IServiceFactory;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.service.video.IRenderer;
	import iface.client.task.ITaskFactory;
	import iface.client.time.ITimelineFactory;
	import iface.client.view.components.IDialogFactory;
	import iface.client.view.IViewFactory;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.highscore.IHighscoreFactory;
	import iface.common.domain.highscore.IHighscoreManager;
	import iface.common.domain.IGameFactory;
	import impl.client.animation.AnimationEngine;
	import impl.client.presentation.GamePresentationFactory;
	import impl.client.service.ServiceFactory;
	import impl.client.task.TaskFactory;
	import impl.client.time.TimelineFactory;
	import impl.client.view.components.DialogFactory;
	import impl.client.view.ViewFactory;
	import iface.common.scope.ISessionScope;
	import iface.common.scope.ISessionScopeFactory;
	import impl.client.workflow.WorkflowEngine;
	import impl.common.domain.GameFactory;
	import impl.common.domain.highscore.HighscoreManager;
	import impl.common.scope.SessionScope;
	import impl.common.scope.SessionScopeFactory;
	import iface.client.configuration.IApplicationConfiguration;
	import impl.client.scope.ApplicationScope;
	import impl.client.configuration.ApplicationConfiguration;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ApplicationScopeFactory 
	{
		private var workflowEngine:IWorkflowEngine = null;
		private var applicationConfiguration:IApplicationConfiguration = null;
		
		public function ApplicationScopeFactory(canvasFactory:ICanvasFactory, soundFactory:ISoundFactory) 
		{
			this.applicationConfiguration = new ApplicationConfiguration();

			var animationEngine:IAnimationEngine = new AnimationEngine();

			var dialogFactory:IDialogFactory = new DialogFactory(canvasFactory, applicationConfiguration);
			var serviceFactory:IServiceFactory = new ServiceFactory(canvasFactory, this.applicationConfiguration, soundFactory);
			var renderer:IRenderer = serviceFactory.getRenderFactory().createRenderer();
			var timelineFactory:ITimelineFactory = new TimelineFactory(applicationConfiguration, serviceFactory, animationEngine);
			var gameFactory:IGameFactory = new GameFactory(applicationConfiguration);
			var sessionScopeFactory:IClientSessionScopeFactory = new ClientSessionScopeFactory( new SessionScopeFactory() );
			var gamePresentationFactory:IGamePresentationFactory = new GamePresentationFactory(applicationConfiguration, animationEngine, canvasFactory, dialogFactory, soundFactory);
			var viewFactory:IViewFactory = new ViewFactory(serviceFactory.getCanvasFactory(), gamePresentationFactory, this.applicationConfiguration);
			var taskFactory:ITaskFactory = new TaskFactory(serviceFactory.getCanvasFactory());
			var highscoreFactory:IHighscoreFactory = gameFactory as IHighscoreFactory;
			var highscoreManager:IHighscoreManager = new HighscoreManager( highscoreFactory );
			var highscorePresentationManagerFactory:IHighscorePresentationManagerFactory = gamePresentationFactory as IHighscorePresentationManagerFactory;
			
			
			workflowEngine = new WorkflowEngine(serviceFactory, viewFactory, taskFactory, timelineFactory, 
												sessionScopeFactory, gameFactory, gamePresentationFactory, highscoreFactory,
												highscoreManager, highscorePresentationManagerFactory, dialogFactory,
												this.applicationConfiguration, renderer );
		}

		public function createApplicationScope():ApplicationScope
		{
			return new ApplicationScope( applicationConfiguration, workflowEngine );
		}
		
	}
	
}