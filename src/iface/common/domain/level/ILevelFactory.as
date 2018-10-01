package iface.common.domain.level 
{
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.domain.score.IScoreManager;
	import impl.common.domain.level.LevelAttributes;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ILevelFactory 
	{
		function createLevel(scoreManager:IScoreManager, levelNum:int ):ILevel;
		function getLevelAttributes( levelNum:int ):LevelAttributes
	}
	
}