package impl.client.presentation.highscore 
{
	import iface.client.presentation.highscore.IHighscorePresentation;
	import iface.client.presentation.score.IScorePresentation;
	import iface.client.presentation.score.IScorePresentationFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HighscorePresentation implements IHighscorePresentation
	{
		private var name:String = null;
		private var scorePresentation:IScorePresentation = null;
		
		public function HighscorePresentation(name:String, score:int, scorePresentationFactory:IScorePresentationFactory) 
		{
			this.name = name;
			this.scorePresentation = scorePresentationFactory.createScorePresentation(score);			
		}
		
		public function getScore():String
		{
			return this.scorePresentation.getScore();
		}
		
		public function getName():String
		{
			return this.name;
		}
		
	}
	
}