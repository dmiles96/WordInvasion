package impl.client.workflow 
{
	import iface.client.scope.IClientSessionScope;
	import iface.client.view.IContinueHandler;
	import iface.common.scope.ISessionScope;
	import iface.client.workflow.IEndGameWorkflow;
	import iface.client.task.IViewTasks;
	import iface.client.view.IView;
	import iface.client.view.IViewFactory;
	import iface.client.workflow.IWorkflowEngine;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EndGameWorkflow implements IContinueHandler, IEndGameWorkflow
	{
		private var viewTasks:IViewTasks;
		private var viewFactory:IViewFactory;
		private var workflowEngine:IWorkflowEngine;
		private var gameSession:IClientSessionScope = null;
		
		public function EndGameWorkflow( 	viewFactory:IViewFactory, viewTasks:IViewTasks, 
											workflowEngine:IWorkflowEngine ) 
		{
			this.viewFactory = viewFactory;
			this.viewTasks = viewTasks;
			this.workflowEngine = workflowEngine;			
		}
		
		public function endGame(gameSession:IClientSessionScope):void
		{
			this.gameSession = gameSession;

			gameSession.getMasterTimeline().stop();
			
			this.viewTasks.removeView( gameSession.getGameView() );

			this.workflowEngine.executeShowHighscoreWorkflow( true, this, gameSession.getGameTimeline().getGame().getScoreManager().getScore() );
		}
		
		public function onContinue():void
		{
			this.workflowEngine.unregisterGameSession(gameSession);
			this.workflowEngine.executeStartGameWorkflow();
		}
	}
	
}