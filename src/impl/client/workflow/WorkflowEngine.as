package impl.client.workflow 
{
	import iface.client.animation.IAnimationEngine;
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.presentation.highscore.IHighscorePresentationManagerFactory;
	import iface.client.presentation.IGamePresentation;
	import iface.client.presentation.IGamePresentationFactory;
	import iface.client.scope.IClientSessionScope;
	import iface.client.scope.IClientSessionScopeFactory;
	import iface.client.service.video.IRenderer;
	import iface.client.service.video.IRenderFactory;
	import iface.client.task.ITaskFactory;
	import iface.client.time.ITimelineFactory;
	import iface.client.view.components.IDialogFactory;
	import iface.client.view.IContinueHandler;
	import iface.client.view.IViewFactory;
	import iface.client.workflow.IHighscoreWorkflow;
	import iface.client.workflow.IRunGameWorkflow;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.highscore.IHighscoreFactory;
	import iface.common.domain.highscore.IHighscoreManager;
	import iface.common.domain.IGame;
	import iface.common.domain.IGameFactory;
	import iface.client.service.IServiceFactory;
	import iface.common.time.ITimeline;
	import iface.client.workflow.IEndGameWorkflow;
	import iface.common.workflow.IStartGameWorkflow;
	import iface.client.presentation.IGamePresentationFactory;
	import impl.common.workflow.WorkflowEngine;
	
	/**
	 * ...
	 * @author ...
	 */
	public class WorkflowEngine extends impl.common.workflow.WorkflowEngine implements IWorkflowEngine
	{
		private var serviceFactory:IServiceFactory = null;
		private var viewFactory:IViewFactory = null;
		private var taskFactory:ITaskFactory = null;
		private var timelineFactory:ITimelineFactory = null;
		private var gameFactory:IGameFactory = null;
		private var gameTimelineFactory:ITimelineFactory = null;
		private var sessionScopeFactory:IClientSessionScopeFactory = null;
		private var gamePresentationFactory:IGamePresentationFactory = null;
		private var highscoreFactory:IHighscoreFactory = null;
		private var highscoreManager:IHighscoreManager = null;
		private var highscorePresentationManagerFactory:IHighscorePresentationManagerFactory = null;
		private var dialogFactory:IDialogFactory = null;
		private var appConfig:IApplicationConfiguration = null;
		private var processInputWorkflow:ProcessInputWorkflow = null;
		private var renderer:IRenderer = null;
		
		public function WorkflowEngine(serviceFactory:IServiceFactory, 
										viewFactory:IViewFactory, 
										taskFactory:ITaskFactory, 										
										timelineFactory:ITimelineFactory,
										sessionScopeFactory:IClientSessionScopeFactory,
										gameFactory:IGameFactory,
										gamePresentationFactory:IGamePresentationFactory,
										highscoreFactory:IHighscoreFactory,
										highscoreManager:IHighscoreManager,
										highscorePresentationManagerFactory:IHighscorePresentationManagerFactory,
										dialogFactory:IDialogFactory,
										appConfig:IApplicationConfiguration,
										renderer:IRenderer)
		{
			this.serviceFactory = serviceFactory;
			this.viewFactory = viewFactory;
			this.taskFactory = taskFactory;
			this.timelineFactory = timelineFactory;
			this.gamePresentationFactory = gamePresentationFactory;
			this.sessionScopeFactory = sessionScopeFactory;
			this.gameTimelineFactory = gameTimelineFactory;
			this.highscoreFactory = highscoreFactory;
			this.highscoreManager = highscoreManager;
			this.highscorePresentationManagerFactory = highscorePresentationManagerFactory;
			this.dialogFactory = dialogFactory;
			this.appConfig = appConfig;
			this.gameFactory = gameFactory;
			this.renderer = renderer;
			
			this.processInputWorkflow = new ProcessInputWorkflow(this.appConfig);
		}
		
		public function getClientSession():IClientSessionScope
		{
			return this.getSession() as IClientSessionScope;
		}
		
		public function executeStartGameWorkflow():void
		{
			var startGameWorkflow:IStartGameWorkflow = new StartGameWorkflow( viewFactory, taskFactory.getViewTasks(), this );
			
			startGameWorkflow.startGame();
		}
		
		public function executeRunGameWorkflow():void
		{			
			var runGameWorkflow:IRunGameWorkflow = new RunGameWorkflow( viewFactory, 
																		taskFactory, 
																		sessionScopeFactory, 
																		this.timelineFactory, 
																		gamePresentationFactory,
																		this, 
																		this.gameFactory,
																		this.renderer);
			
			runGameWorkflow.runGame();
		}
		
		public function executeProcessInputWorkflow( keyStates:Object ):void
		{
			this.processInputWorkflow.processInput(this.getSession(), keyStates);
		}
		
		public function executeEndGameWorkflow():void
		{
			var endGameWorkflow:IEndGameWorkflow = new EndGameWorkflow( this.viewFactory, this.taskFactory.getViewTasks(), this );
			
			endGameWorkflow.endGame(this.getClientSession());
		}
		
		public function executeShowHighscoreWorkflow( enterName:Boolean, onContinueHandler:IContinueHandler, score:int = 0 ):void
		{
			var showHighscoreWorkflow:IHighscoreWorkflow = new HighscoreWorkflow( 	this.viewFactory, this.taskFactory.getViewTasks(), this, this.highscoreFactory, this.highscoreManager, this.highscorePresentationManagerFactory, 
																					this.appConfig.getPlayAreaWidth(), this.appConfig.getPlayAreaHeight(), this.appConfig.getLeftDialogMargin(), this.dialogFactory  );
			
			showHighscoreWorkflow.showHighScores( enterName, score, onContinueHandler );
		}
	}
	
}