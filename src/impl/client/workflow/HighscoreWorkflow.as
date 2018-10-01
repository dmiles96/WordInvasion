package impl.client.workflow 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import iface.client.presentation.highscore.IHighscorePresentationManager;
	import iface.client.presentation.highscore.IHighscorePresentationManagerFactory;
	import iface.client.task.IViewTasks;
	import iface.client.view.ClickEvent;
	import iface.client.view.components.IDialog;
	import iface.client.view.components.IDialogFactory;
	import iface.client.view.components.IHighscoreNameDialog;
	import iface.client.view.components.IOnCloseHandler;
	import iface.client.view.IClickHandler;
	import iface.client.view.IContinueHandler;
	import iface.client.view.IHighscoreView;
	import iface.client.view.IView;
	import iface.client.view.IViewFactory;
	import iface.client.workflow.IHighscoreWorkflow;
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.highscore.IHighscore;
	import iface.common.domain.highscore.IHighscoreFactory;
	import iface.common.domain.highscore.IHighscoreManager;
	import impl.client.view.components.HighscoreNameDialog;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HighscoreWorkflow implements IOnCloseHandler, IHighscoreWorkflow, IClickHandler
	{
		private var viewTasks:IViewTasks = null;
		private var viewFactory:IViewFactory = null;
		private var workflowEngine:IWorkflowEngine = null;
		private var highScoreView:IHighscoreView = null;
		private var newHighscoreIndex:int = -1;
		private var newHighscore:int = 0;
		private var highscoreFactory:IHighscoreFactory = null;
		private var highscorePresentationManagerFactory:IHighscorePresentationManagerFactory = null;
		private var highscores:Array = null;
		private var onContinueHandler:IContinueHandler = null;
		private var highscoreManager:IHighscoreManager = null;
		private var dialogFactory:IDialogFactory = null;
		private var playAreaWidth:int = 0;
		private var playAreaHeight:int = 0
		private var leftDialogMargin:int = 0;
		
		public function HighscoreWorkflow(	viewFactory:IViewFactory, viewTasks:IViewTasks, 
											workflowEngine:IWorkflowEngine, highscoreFactory:IHighscoreFactory, 
											highscoreManager:IHighscoreManager, highscorePresentationManagerFactory:IHighscorePresentationManagerFactory,
											playAreaWidth:int, playAreaHeight:int, leftDialogMargin:int, dialogFactory:IDialogFactory) 
		{
			this.viewFactory = viewFactory;
			this.viewTasks = viewTasks;
			this.workflowEngine = workflowEngine;
			this.highscoreFactory = highscoreFactory;
			this.highscoreManager = highscoreManager;
			this.highscorePresentationManagerFactory = highscorePresentationManagerFactory;
			this.playAreaWidth = playAreaWidth;
			this.playAreaHeight = playAreaHeight;
			this.leftDialogMargin = leftDialogMargin;
			this.dialogFactory = dialogFactory;
		}
		
		public function showHighScores( enterName:Boolean, newHighscore:int, onContinueHandler:IContinueHandler ):void
		{
			this.newHighscore = newHighscore;
			this.onContinueHandler = onContinueHandler;
			
			this.highscores = highscoreManager.load();
			this.highScoreView = viewFactory.createHighscoreView(this);
			this.viewTasks.showView(this.highScoreView);
			
			if ( enterName )
			{
				this.findScorePosition();
				if ( this.newHighscoreIndex > -1 )
				{
					var dialogLocation:Point = new Point( this.leftDialogMargin, (this.playAreaHeight / 2) - (this.playAreaHeight / 8) );
					var dialogWidth:int = this.playAreaWidth - (this.leftDialogMargin * 2);
					var dialogHeight:int = this.playAreaHeight / 4;
					var highscoreNameDialog:IHighscoreNameDialog = dialogFactory.createHighscoreNameDialog(dialogLocation, dialogWidth, dialogHeight, this );
				
					highscoreNameDialog.show(this.highScoreView.getCanvas());
				}
				else
				{
					this.updateHighscores();
				}
			}
			else
			{
				this.updateHighscores();
			}
			
		}

		public function onClose(dialog:IDialog):void
		{
			var highscoreNameDialog:IHighscoreNameDialog = dialog as IHighscoreNameDialog;
			var name:String = highscoreNameDialog.getName();
			
			this.addScoreToList( name );
			this.highscoreManager.save( this.highscores );
			this.updateHighscores();
		}
		
		public function onClick(event:ClickEvent):void
		{
			this.viewTasks.removeView(this.highScoreView);
			this.onContinueHandler.onContinue();
		}
		
		private function findScorePosition():void
		{
			for ( var highscoreIndex:int = 0; highscoreIndex < highscores.length; highscoreIndex++ )
			{
				var curHighscore:IHighscore = highscores[highscoreIndex];
				
				if ( this.newHighscore >= curHighscore.getScore() )
				{
					this.newHighscoreIndex = highscoreIndex;
					break;
				}
			}
		}
		
		private function addScoreToList( name:String ):void
		{
			this.highscores.pop();
			this.highscores.splice(this.newHighscoreIndex, 0, this.highscoreFactory.createHighscore(name, this.newHighscore) );
			
			this.updateHighscores();
		}
		
		private function updateHighscores():void
		{
			var highscorePresentationManager:IHighscorePresentationManager = highscorePresentationManagerFactory.createHighscorePresentationManager(this.highscores);
			
			highScoreView.showScores(highscorePresentationManager.getHighscorePresentations());
		}

	}
	
}