package impl.client.presentation.score 
{
	import iface.client.presentation.score.IScorePresentation;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScorePresentation implements IScorePresentation
	{
		private var scoreAsString:String = null;
		private var maxScoreToDisplay:int = 0;
		
		public function ScorePresentation(score:int, maxScoreToDisplay:int) 
		{
			this.maxScoreToDisplay = maxScoreToDisplay;

			this.updateScore( score );
		}
		
		public function updateScore( updatedScore:int ):void
		{
			if ( updatedScore > this.maxScoreToDisplay )
			{
				updatedScore = updatedScore % this.maxScoreToDisplay;
			}
			
			this.scoreAsString = updatedScore.toString();
		}
		
		public function getScore():String
		{
			return this.scoreAsString;
		}
	}
	
}