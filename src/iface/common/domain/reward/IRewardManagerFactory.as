package iface.common.domain.reward 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IRewardManagerFactory 
	{
		function createRewardManager( rewardExectutor:IRewardExecutor ):IRewardManager;
	}
	
}