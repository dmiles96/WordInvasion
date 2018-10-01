package impl.client.workflow 
{
	import flash.events.MouseEvent;
	import iface.client.task.IViewTasks;
	import iface.client.view.ClickEvent;
	import iface.client.view.IClickHandler;
	import iface.client.view.IContinueHandler;
	import iface.client.view.IView;
	import iface.client.view.IViewFactory;
	import iface.client.workflow.IRunGameWorkflow;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.workflow.IStartGameWorkflow;
	import impl.client.view.GameMenuView;
	
	/**
	 * ...
	 * @author ...
	 */
	public class StartGameWorkflow implements IContinueHandler, IStartGameWorkflow, IClickHandler
	{
		private var viewTasks:IViewTasks;
		private var viewFactory:IViewFactory;
		private var workflowEngine:IWorkflowEngine;
		private var gameMenuView:IView = null;
		
		public function StartGameWorkflow( 	viewFactory:IViewFactory, viewTasks:IViewTasks, 
											workflowEngine:IWorkflowEngine ) 
		{
			this.viewFactory = viewFactory;
			this.viewTasks = viewTasks;
			this.workflowEngine = workflowEngine;
		}
		
		public function startGame():void
		{
			this.gameMenuView = viewFactory.createGameMenuView(this, this);
			
			this.viewTasks.showView(gameMenuView);
		}
		
		public function onClick(event:ClickEvent):void
		{
			if ( event.getData() == "play" )
			{
				this.viewTasks.removeView(this.gameMenuView);
				this.gameMenuView = null;
				
				workflowEngine.executeRunGameWorkflow();
			}
			else if ( event.getData() == "highscores" )
			{
				this.viewTasks.removeView(this.gameMenuView);
				this.gameMenuView = null;
				
				workflowEngine.executeShowHighscoreWorkflow(false, this );
			}
		}
		
		public function onContinue():void
		{
			this.workflowEngine.executeStartGameWorkflow();
		}
		
	}
	
}