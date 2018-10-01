package impl.common.domain.reward 
{
	import iface.common.domain.reward.IRewardExecutor;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelReward 
	{
		private var rewardExecutor:IRewardExecutor = null;
		private var levelThreshold:int = 0;
		
		public function LevelReward( levelThreshold:int, rewardExecutor:IRewardExecutor ) 
		{
			this.rewardExecutor = rewardExecutor;
			this.levelThreshold = levelThreshold;
		}
		
		public function isLevelRewarded( levelNum:int ):Boolean
		{
			if ( levelNum >= this.levelThreshold )
			{
				return true;
			}
			
			return false;
		}
		
		public function rewardLevel( levelNum:int ):void
		{
			if ( this.isLevelRewarded( levelNum ) )
			{
				this.rewardExecutor.repairCity();
			}
		}
		
		public function generateNextLevelReward():void
		{
			this.levelThreshold += levelThreshold;
		}
	}
	
}