package impl.common.domain.level 
{
	import iface.common.domain.enemy.IVelocityComputer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelAttributes implements IVelocityComputer
	{
		private var gameTicksPerSecond:int = 0;
		private var distanceToCity:int = 0;
		private var playAreaWidth:int = 0;
		private var shouldAimEnemies:Boolean = false;
		private var tickThresholdForAddingEnemies:int = 0;
		private var enemyCountThresholdForAimingEnemies:int = 0;
		private var tickThresholdUsingSpecialAbilities:int = 0;
		private var shouldShowBonusEnemy:Boolean = false;
		private var tickThresholdForShowingBonusEnemy:int = 0;
		private var minTickThresholdForShowingBonusEnemy:int = 0;
		private var maxTickThresholdForShowingBonusEnemy:int = 0;
		private var enemyTypes:Array = null;
		private var secondsToReachCity:int = 0;
		private var secondsToAccelBy:int = 0;
		private var tickThresholdForAcceleration:int = 0;
		private var numTimesToAccelerate:int = 0;
		private var bonusEnemySecondsToOffscreen:int = 0;
		private var shouldShowPowerUp:Boolean = false;
		private var enemyCountThresholdForShowingPowerUp:int = 0;
		private var minEnemyCountThresholdForShowingPowerUp:int = 0;
		private var maxEnemyCountThresholdForShowingPowerUp:int = 0;
		private var availablePowerUps:Array = null;
		private var numEnemiesToCreate:int = 0;
		private var secondsForBombToReachCity:int = 0;
		private var startMessages:Array = null;
		
		public function LevelAttributes(	gameTicksPerSecond:int,
											playAreaWidth:int,
											distanceToCity:int,
											shouldAimEnemies:Boolean,
											tickThresholdForAddingEnemies:int, 
											enemyCountThresholdForAimingEnemies:int,
											tickThresholdUsingSpecialAbilities:int,
											shouldShowBonusEnemy:Boolean,
											minTickThresholdForShowingBonusEnemy:int,
											maxTickThresholdForShowingBonusEnemy:int,
											enemyTypes:Array,
											secondsToReachCity:int,
											secondsToAccelBy:int,
											tickThresholdForAcceleration:int,
											numTimesToAccelerate:int,
											bonusEnemySecondsToOffscreen:int,
											shouldShowPowerUp:Boolean,
											minEnemyCountThresholdForShowingPowerUp:int,
											maxEnemyCountThresholdForShowingPowerUp:int,
											availablePowerUps:Array,
											numEnemiesToCreate:int,
											secondsForBombToReachCity:int,
											startMessages:Array)
		{
			this.gameTicksPerSecond = gameTicksPerSecond;
			this.playAreaWidth = playAreaWidth;
			this.distanceToCity = distanceToCity;
			this.shouldAimEnemies = shouldAimEnemies;
			this.tickThresholdForAddingEnemies = tickThresholdForAddingEnemies;
			this.enemyCountThresholdForAimingEnemies = enemyCountThresholdForAimingEnemies;
			this.tickThresholdUsingSpecialAbilities = tickThresholdUsingSpecialAbilities;
			this.shouldShowBonusEnemy = shouldShowBonusEnemy;
			this.minTickThresholdForShowingBonusEnemy = minTickThresholdForShowingBonusEnemy;
			this.maxTickThresholdForShowingBonusEnemy = maxTickThresholdForShowingBonusEnemy;
			this.enemyTypes = enemyTypes;
			this.secondsToReachCity = secondsToReachCity;
			this.secondsToAccelBy = secondsToAccelBy;
			this.tickThresholdForAcceleration = tickThresholdForAcceleration;
			this.numTimesToAccelerate = numTimesToAccelerate;
			this.bonusEnemySecondsToOffscreen = bonusEnemySecondsToOffscreen;
			this.shouldShowPowerUp = shouldShowPowerUp;
			this.minEnemyCountThresholdForShowingPowerUp = minEnemyCountThresholdForShowingPowerUp;
			this.maxEnemyCountThresholdForShowingPowerUp = maxEnemyCountThresholdForShowingPowerUp;
			this.availablePowerUps = availablePowerUps;
			this.numEnemiesToCreate = numEnemiesToCreate;
			this.secondsForBombToReachCity = secondsForBombToReachCity;
			this.startMessages = startMessages;
			
			if ( (availablePowerUps == null) || (availablePowerUps.length == 0) )
			{
				this.shouldShowPowerUp = false;
			}
			
			this.generateTickThresholdForShowingBonusEnemy();
			this.generateTickThresholdForShowingPowerUp();
		}

		public static function computeTickForAddingEnemies( gameTicksPerSeciond:int, gameTicksDivisor:int ):int
		{
			return Math.ceil( gameTicksPerSeciond / gameTicksDivisor );
		}
		
		public function getShouldAimEnemies():Boolean
		{
			return shouldAimEnemies;
		}
		
		public function getTickThresholdForAddingEnemies():int
		{
			return this.tickThresholdForAddingEnemies;
		}
		
		public function getEnemyCountThresholdForAimingEnemies():int
		{
			return this.enemyCountThresholdForAimingEnemies;
		}
		
		public function getTickThresholdUsingSpecialAbilities():int
		{
			return this.tickThresholdUsingSpecialAbilities;
		}
		
		public function getShouldShowBonusEnemy():Boolean
		{
			return this.shouldShowBonusEnemy;
		}
		
		public function getTickThresholdForShowingBonusEnemy():int
		{
			return this.tickThresholdForShowingBonusEnemy;
		}

		public function getEnemyTypes():Array
		{
			return this.enemyTypes;
		}
		
		public function getTickThresholdForAcceleration():int
		{
			return this.tickThresholdForAcceleration;
		}
		
		public function getNumTimesToAccelerate():int
		{
			return this.numTimesToAccelerate;
		}
		
		public function getShouldShowPowerUp():Boolean
		{
			return this.shouldShowPowerUp;
		}
		
		public function getRandomPowerUpType():int
		{
			return this.availablePowerUps[Math.floor( Math.random() * this.availablePowerUps.length )];
		}
		
		public function getNumEnemiesToCreate():int
		{
			return this.numEnemiesToCreate;
		}
		
		public function getRandomEnemyType():int
		{
			return this.enemyTypes[Math.floor(Math.random() * enemyTypes.length)];
		}
		
		public function accelerate():void
		{
			this.secondsToReachCity -= this.secondsToAccelBy;
		}
		
		public function computeFallingEnemyVelocity( height:int ):Number
		{
			return this.computeVelocity( this.distanceToCity, this.secondsToReachCity, -height );
		}

		public function computeFlyingEnemyVelocity( width:int ):Number
		{
			return this.computeVelocity( this.playAreaWidth, this.bonusEnemySecondsToOffscreen, width );
		}

		public function computeBombVelocity( height:int ):Number
		{
			return this.computeVelocity( this.distanceToCity, this.secondsForBombToReachCity, -height );
		}
		
		private function computeVelocity( distanceToDestination:int, secondsToDestination:int, offset:int ):Number
		{
			return ((distanceToDestination + offset) / secondsToDestination) / this.gameTicksPerSecond;
		}
		
		public function generateTickThresholdForShowingBonusEnemy():void
		{
			this.tickThresholdForShowingBonusEnemy = Math.floor( Math.random() * this.maxTickThresholdForShowingBonusEnemy ) + this.minTickThresholdForShowingBonusEnemy;

			if ( this.tickThresholdForShowingBonusEnemy > this.maxTickThresholdForShowingBonusEnemy )
				this.tickThresholdForShowingBonusEnemy = this.maxTickThresholdForShowingBonusEnemy;
		}
		
		public function generateTickThresholdForShowingPowerUp():void
		{
			this.enemyCountThresholdForShowingPowerUp = Math.floor( Math.random() * this.maxEnemyCountThresholdForShowingPowerUp ) + this.minEnemyCountThresholdForShowingPowerUp;

			if ( this.enemyCountThresholdForShowingPowerUp > this.maxEnemyCountThresholdForShowingPowerUp )
				this.enemyCountThresholdForShowingPowerUp = this.maxEnemyCountThresholdForShowingPowerUp;
		}
		
		
		public function isAtEnemyCountThresholdForShowingPowerUp( shouldShowPowerUpCoutner:int ):Boolean
		{
			if ( this.shouldShowPowerUp )
			{
				return this.enemyCountThresholdForShowingPowerUp <= shouldShowPowerUpCoutner;
			}
			
			return false;			
		}
		
		public function isAtTickThresholdForShowingBonusEnemy( showBonusEnemyCounter:int ):Boolean
		{
			if ( this.shouldShowBonusEnemy )
			{
				return this.tickThresholdForShowingBonusEnemy <= showBonusEnemyCounter;
			}
			
			return false;
		}
		
		public function isAtEnemyCountForAimThreshold( enemyAimCounter:int ):Boolean
		{
			if ( this.shouldAimEnemies )
			{
				return this.enemyCountThresholdForAimingEnemies <= enemyAimCounter;
			}
			
			return false;
		}
		
		public function isAtThresholdForAddingEnemies( addEnemyCounter:int ):Boolean
		{
			return this.tickThresholdForAddingEnemies <= addEnemyCounter;
		}
		
		public function isAtMaxEnemiesToCreate( enemiesCreatedCounter:int ):Boolean
		{
			return this.numEnemiesToCreate <= enemiesCreatedCounter;
		}
		
		public function getStartMessages():Array
		{
			return this.startMessages;
		}
	}
	
}