package impl.common.domain.reward 
{
	import iface.common.domain.reward.IRewardExecutor;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScoreReward 
	{
		private var scoreThreshold:int = 0;
		private var rewardExecutor:IRewardExecutor = null;
		
		public function ScoreReward( scoreThreshold:int, rewardExecutor:IRewardExecutor ) 
		{
			
			this.scoreThreshold = scoreThreshold;
			this.rewardExecutor = rewardExecutor;
		}
		
		public function isScoreRewarded( score:int ):Boolean
		{
			if ( score >= this.scoreThreshold )
			{
				return true;
			}
			
			return false;
		}
		
		public function rewardScore( score:int ):void
		{
			if ( this.isScoreRewarded( score ) )
			{
				this.rewardExecutor.addRandomPowerup();
			}
		}
		
		public function generateNextScoreReward():void
		{
			this.scoreThreshold += this.scoreThreshold;
		}
	}
	
}