package impl.client.presentation.highscore 
{
	import iface.client.presentation.highscore.IHighscorePresentation;
	import iface.client.presentation.highscore.IHighscorePresentationFactory;
	import iface.client.presentation.highscore.IHighscorePresentationManager;
	import iface.common.domain.highscore.IHighscore;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HighscorePresentationManager implements IHighscorePresentationManager
	{
		private var highscorePresentations:Array = new Array();
		
		public function HighscorePresentationManager( highscores:Array, highscorePresentationFactory:IHighscorePresentationFactory ) 
		{
			for each( var highscore:IHighscore in highscores )
			{
				highscorePresentations.push( highscorePresentationFactory.createHighscorePresentation( highscore ));
			}
		}
		
		public function getHighscorePresentations():Array
		{
			return this.highscorePresentations;
		}

	}
	
}