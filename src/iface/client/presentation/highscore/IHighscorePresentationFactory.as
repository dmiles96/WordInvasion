package iface.client.presentation.highscore 
{
	import iface.common.domain.highscore.IHighscore;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IHighscorePresentationFactory 
	{
		function createHighscorePresentation( highscore:IHighscore ):IHighscorePresentation;
	}
	
}