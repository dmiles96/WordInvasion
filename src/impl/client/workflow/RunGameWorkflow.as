package impl.client.workflow
{
	import iface.client.animation.IAnimationEngine;
	import iface.client.presentation.IGamePresentation;
	import iface.client.presentation.IGamePresentationFactory;
	import iface.client.scope.IClientSessionScope;
	import iface.client.scope.IClientSessionScopeFactory;
	import iface.client.service.video.IRenderer;
	import iface.client.service.video.IRenderFactory;
	import iface.client.task.ITaskFactory;
	import iface.client.time.IAnimationTimeline;
	import iface.client.time.ITimelineFactory;
	import iface.client.view.IGameView;
	import iface.client.view.IViewFactory;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.IGame;
	import iface.common.domain.IGameFactory;
	import iface.common.time.IGameTimeline;
	import iface.common.time.IMasterTimeline;
	import iface.common.time.ITimeline;
	import iface.client.workflow.IRunGameWorkflow;
	import impl.client.view.GameView;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RunGameWorkflow implements IRunGameWorkflow
	{
		private var sessionScopeFactory:IClientSessionScopeFactory = null;
		private var timelineFactory:ITimelineFactory = null;
		private var viewFactory:IViewFactory = null;
		private var taskFactory:ITaskFactory = null;
		private var workflowEngine:IWorkflowEngine = null;
		private var gamePresentationFactory:IGamePresentationFactory = null;
		private var gameFactory:IGameFactory = null;
		private var renderer:IRenderer = null;
		
		public function RunGameWorkflow(viewFactory:IViewFactory, 
										taskFactory:ITaskFactory, 
										sessionScopeFactory:IClientSessionScopeFactory, 
										timelineFactory:ITimelineFactory,
										gamePresentationFactory:IGamePresentationFactory,
										workflowEngine:IWorkflowEngine,
										gameFactory:IGameFactory,
										renderer:IRenderer)
		{
			this.sessionScopeFactory = sessionScopeFactory;
			this.timelineFactory = timelineFactory;
			this.viewFactory = viewFactory;
			this.taskFactory = taskFactory;
			this.workflowEngine = workflowEngine;
			this.gamePresentationFactory = gamePresentationFactory;
			this.gameFactory = gameFactory;
			this.renderer = renderer;
		}
		
		public function runGame():void
		{	
			var game:IGame = gameFactory.createGame();
			var masterTimeline:IMasterTimeline = timelineFactory.createMasterTimeline();
			var gameTimeline:IGameTimeline = timelineFactory.createGameTimeline(game, this.workflowEngine);
			var inputTimeline:ITimeline = timelineFactory.createInputTimeline(this.workflowEngine);
			var animationTimeline:IAnimationTimeline = timelineFactory.createAnimationTimeline();
			var gameView:IGameView = this.viewFactory.createGameView(game);
			var gameSession:IClientSessionScope = sessionScopeFactory.createSessionScope(gameView, masterTimeline, gameTimeline);
			
			this.workflowEngine.registerSession(gameSession);
			
			//input timline should come first, so on the same tick, the game can update based on new state
			masterTimeline.addTimeline(inputTimeline);
			
			//these are updates to the game world
			masterTimeline.addTimeline(gameTimeline);
			
			//presentation is last, so we can render any game world updates on the same tick they might happen
			masterTimeline.addTimeline(animationTimeline);
			
			renderer.addUpdateRegion(gameView.getUpdateRegion());
			this.taskFactory.getViewTasks().showView(gameView);

			game.start();
			masterTimeline.start();
		}
	
	}
	
}