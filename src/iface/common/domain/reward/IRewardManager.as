package iface.common.domain.reward 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IRewardManager 
	{
		function isLevelRewarded( levelNum:int ):Boolean;
		function rewardLevel( levelNum:int ):void;
		function generateNextLevelReward():void;
		function isScoreRewarded( score:int ):Boolean;
		function rewardScore( score:int ):void;
		function generateNextScoreReward():void;
	}
	
}