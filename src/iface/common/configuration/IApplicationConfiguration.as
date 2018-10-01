package iface.common.configuration
{
	import iface.common.domain.enemy.IEnemySizeComputer;

	/**
	 * ...
	 * @author ...
	 */
	public interface IApplicationConfiguration
	{
		function getMillisecondsPerTick():int;
		function getGameUpdatesPerSecond():int;
		function getTicksForPausePowerUpToPause():int;
		function getMaxNumPowerUps():int;
		function getLevelRewardThreshold():int;
		function getScoreRewardThreshold():int;
		function getNonExsistantLetterAmount():int;
		function getTypoAmount():int;
		function getPerCharacterAmount():int;
		function getBombAmount():int;
		function getPerBonusWordCharacterFactor():int;
		function getPerMissingCharacterBonusFactor():int;
		function getPerCharacterBonusAmountForNoUndroppedCharacters():int;
		function getCityYOffset():int;
		function getPlayAreaWidth():int;
		function getPlayAreaHeight():int;
		function getEnemyStartY():int;
		function getMaxBuildingHeight():int;
		function getMinBuildingWidth():int;
		function getMaxBuildingWidth():int;
		function getEnemySizeComputer():IEnemySizeComputer;
		function getTicksForExnemyExplosion():int;
		function getProjectileVelocity():Number;
	}
	
}