package impl.common.configuration
{
	import iface.common.configuration.IApplicationConfiguration;
	import iface.common.domain.IGame;
	import iface.common.time.ITimeline;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ApplicationConfiguration
	{
		private const millisecondsPerTick:int = 33;
		private const gameUpdatesPerSecond:int = 30;
		private const secondsForPausePowerUpToPause:int = 5;
		private const maxNumPowerUps:int = 3;
		private const levelRewardThreshold:int = 50;
		private const scoreRewardThreshold:int = 10000;
		private const nonExsistantLetterAmount:int = 1;
		private const typoAmount:int = 2;
		private const perCharacterAmount:int = 2;
		private const bombAmount:int = 5;
		private const perBonusWordCharacterFactor:int = 2
		private const perMissingCharacterBonusFactor:int = 3;
		private const perCharacterBonusAmountForNoUndroppedCharacters:int = 1;
		private const cityYOffset:int = 450;
		private const playAreaWidth:int = 640;
		private const playAreaHeight:int = 480;
		private const enemyStartY:int = 50;
		private const maxBuildingHeight:int = 30;
		private const minBuildingWidth:int = 10;
		private const maxBuildingWidth:int = 20;
		private var ticksForEnemyExplsion:int = 0;
		private var projectileVelocity:Number = 0;
		
		public function ApplicationConfiguration() 
		{
			this.ticksForEnemyExplsion = gameUpdatesPerSecond;
			this.projectileVelocity = this.cityYOffset / this.gameUpdatesPerSecond * 2;
		}
		
		public function getMillisecondsPerTick():int { return this.millisecondsPerTick; }
		public function getGameUpdatesPerSecond():int { return gameUpdatesPerSecond; }
		public function getTicksForPausePowerUpToPause():int { return this.secondsForPausePowerUpToPause * this.gameUpdatesPerSecond; }
		public function getMaxNumPowerUps():int { return maxNumPowerUps; }
		public function getLevelRewardThreshold():int { return levelRewardThreshold; }
		public function getScoreRewardThreshold():int { return scoreRewardThreshold; }
		public function getNonExsistantLetterAmount():int { return nonExsistantLetterAmount; }
		public function getTypoAmount():int { return typoAmount; }
		public function getPerCharacterAmount():int { return perCharacterAmount; }
		public function getBombAmount():int { return bombAmount; }
		public function getPerBonusWordCharacterFactor():int { return perBonusWordCharacterFactor; }
		public function getPerMissingCharacterBonusFactor():int { return perMissingCharacterBonusFactor; }
		public function getPerCharacterBonusAmountForNoUndroppedCharacters():int { return perCharacterBonusAmountForNoUndroppedCharacters; }		
		public function getCityYOffset():int { return this.cityYOffset; }
		public function getPlayAreaWidth():int { return this.playAreaWidth; }
		public function getPlayAreaHeight():int { return this.playAreaHeight; }
		public function getEnemyStartY():int { return this.enemyStartY; }
		public function getMaxBuildingHeight():int { return this.maxBuildingHeight; }
		public function getMinBuildingWidth():int { return this.minBuildingWidth; }
		public function getMaxBuildingWidth():int { return this.maxBuildingWidth; }
		public function getTicksForExnemyExplosion():int { return this.ticksForEnemyExplsion; }
		public function getProjectileVelocity():Number { return this.projectileVelocity; }
	}
	
}