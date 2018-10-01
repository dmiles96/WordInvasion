package impl.common.domain.reward 
{
	import iface.common.domain.reward.IRewardExecutor;
	import iface.common.domain.reward.IRewardManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RewardManager implements IRewardManager
	{
		private var levelReward:LevelReward = null;
		private var scoreReward:ScoreReward = null;
		
		public function RewardManager(levelThreshold:int, scoreThreshold:int, rewardExecutor:IRewardExecutor) 
		{
			this.levelReward = new LevelReward( levelThreshold, rewardExecutor );
			this.scoreReward = new ScoreReward( scoreThreshold, rewardExecutor );
		}

		public function isLevelRewarded( levelNum:int ):Boolean
		{
			return this.levelReward.isLevelRewarded( levelNum );
		}
		
		public function rewardLevel( levelNum:int ):void
		{
			this.levelReward.rewardLevel( levelNum );
		}
		
		public function generateNextLevelReward():void
		{
			this.levelReward.generateNextLevelReward();
		}
		
		public function isScoreRewarded( score:int ):Boolean
		{
			return this.scoreReward.isScoreRewarded( score );
		}
		
		public function rewardScore( score:int ):void
		{
			this.scoreReward.rewardScore( score );
		}
		
		public function generateNextScoreReward():void
		{
			this.scoreReward.generateNextScoreReward();
		}
	}
	
}