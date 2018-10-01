package iface.common.domain.score 
{
	import iface.common.domain.reward.IRewardManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IScoreManagerFactory 
	{
		function createScoreManager( rewardManager:IRewardManager ):IScoreManager;
	}
	
}