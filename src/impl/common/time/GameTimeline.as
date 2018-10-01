package impl.common.time
{
	import iface.client.workflow.IWorkflowEngine;
	import iface.common.domain.IGame;
	import iface.common.time.IGameTimeline;
	import iface.common.time.ITimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameTimeline extends Timeline implements IGameTimeline
	{
		private var game:IGame = null;
		private var workflowEngine:IWorkflowEngine = null;
		
		public function GameTimeline(gameUpdatesPerSecond:int, game:IGame, workflowEngine:IWorkflowEngine) 
		{
			super( gameUpdatesPerSecond );
			
			this.game = game;
			this.workflowEngine = workflowEngine;
		}
		
		public function getGame():IGame
		{
			return this.game;
		}
		
		public override function tick( tickDelta:int ):void
		{
			this.game.tick(tickDelta);
			
			if ( this.game.isEnded() )
				this.workflowEngine.executeEndGameWorkflow();
		}

	}
	
}