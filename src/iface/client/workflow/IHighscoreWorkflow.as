package iface.client.workflow 
{
	import iface.client.view.IContinueHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IHighscoreWorkflow 
	{
		function showHighScores( enterName:Boolean, newHighscore:int, onContinueHandler:IContinueHandler ):void;
	}
	
}