package impl.common.domain.level 
{
	import iface.common.domain.city.ICity;
	import iface.common.domain.enemy.EnemyTypes;
	import iface.common.domain.enemy.IEnemyFactory;
	import iface.common.domain.level.ILevel;
	import iface.common.domain.level.ILevelFactory;
	import iface.common.domain.powerup.IPowerUpManagerFactory;
	import iface.common.domain.powerup.PowerUpTypes;
	import iface.common.domain.score.IScoreManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelFactory implements ILevelFactory
	{
		private var enemyFactory:IEnemyFactory = null;
		private var city:ICity = null;
		private var playAreaWidth:int = 0;
		private var playAreaHeight:int = 0;
		private var levels:Array = new Array();
		private var enemyStartY:int = 0;
		private var powerUpManagerFactory:IPowerUpManagerFactory = null;
		private var gameTicksPerSecond:int = 0;
		private var distanceToCity:int = 0;
		private var randomContinuationMessages:Array = new Array();
		private var minTickThresholdForAddingEnemies:int = 0;
		private var minEnemyCountThresholdForAimingEnemies:int = 2;
		private var minSecondsToReachCity:int = 15;
		private var minBonusEnemySecondsToOffscreen:int = 5;
		
		//level attributes
		private var shouldAimEnemies:Boolean;
		private var tickThresholdForAddingEnemies:int;
		private var enemyCountThresholdForAimingEnemies:int;
		private var tickThresholdUsingSpecialAbilities:int;
		private var shouldShowBonusEnemy:Boolean;
		private var minTickThresholdForShowingBonusEnemy:int;
		private var maxTickThresholdForShowingBonusEnemy:int;
		private var enemyTypes:Array
		private var secondsToReachCity:int;
		private var secondsToAccelBy:int;
		private var tickThresholdForAcceleration:int;
		private var numTimesToAccelerate:int;
		private var bonusEnemySecondsToOffscreen:int;
		private var shouldShowPowerUp:Boolean;
		private var minEnemyCountThresholdForShowingPowerUp:int;
		private var maxEnemyCountThresholdForShowingPowerUp:int;
		private var availablePowerUps:Array;
		private var numEnemiesToCreate:int;
		private var secondsForBombToReachCity:int;
		private var startMessages:Array;
		private var rewardedLevel:int = 0;
		private var rewardedScore:int = 0;
		
		public function LevelFactory( gameTicksPerSecond:int, cityYOffset:int, enemyFactory:IEnemyFactory, city:ICity, playAreaWidth:int, playAreaHeight:int, enemyStartY:int, powerUpManagerFactory:IPowerUpManagerFactory, rewardedLevel:int, rewardedScore:int  ) 
		{
			this.enemyFactory = enemyFactory;
			this.city = city;
			this.playAreaWidth = playAreaWidth;
			this.playAreaHeight = playAreaHeight;
			this.enemyStartY = enemyStartY;
			this.powerUpManagerFactory = powerUpManagerFactory;
			this.gameTicksPerSecond = gameTicksPerSecond;
			this.distanceToCity = cityYOffset - enemyStartY;
			this.rewardedLevel = rewardedLevel;
			this.rewardedScore = rewardedScore;
			this.minTickThresholdForAddingEnemies = this.gameTicksPerSecond / 2;
			
			this.randomContinuationMessages.push( "The next wave is coming. Get ready!" );
			this.randomContinuationMessages.push( "Don't quit before they do. Keep up the good work!" );
			this.randomContinuationMessages.push( "Hang in there!" );
			this.randomContinuationMessages.push( "Finish the fight!" );
			
			this.createDatabase();
		}

		private function createDatabase():void
		{
			//Level 1
			shouldAimEnemies = false;
			tickThresholdForAddingEnemies = this.secondsToTicks(1.5);
			enemyCountThresholdForAimingEnemies = 0;
			tickThresholdUsingSpecialAbilities = 0;
			shouldShowBonusEnemy = false;
			minTickThresholdForShowingBonusEnemy = 0;
			maxTickThresholdForShowingBonusEnemy = 0;
			enemyTypes = new Array();
			enemyTypes.push( EnemyTypes.NORMAL_WORD_ENEMY_TYPE );
			secondsToReachCity = 60;
			secondsToAccelBy = .5;
			tickThresholdForAcceleration = this.secondsToTicks(60);
			numTimesToAccelerate = 10;
			bonusEnemySecondsToOffscreen = 0;
			shouldShowPowerUp = false;
			minEnemyCountThresholdForShowingPowerUp = 0;
			maxEnemyCountThresholdForShowingPowerUp = 0;
			numEnemiesToCreate = 10;
			secondsForBombToReachCity = 5;
			startMessages = new Array();
			startMessages.push( "Words are invading! Protect thousands of innocent lives by typing the words before they destroy your city." );
									
			this.levels.push( createLevelAttr() );
			
			//Level 2
			shouldAimEnemies = false;
			tickThresholdForAddingEnemies = decreaseTickThresholdForAddingEnemies();
			enemyCountThresholdForAimingEnemies = 0;
			tickThresholdUsingSpecialAbilities = 0;
			shouldShowBonusEnemy = false;
			minTickThresholdForShowingBonusEnemy = 0;
			maxTickThresholdForShowingBonusEnemy = 0;
			enemyTypes = new Array();
			enemyTypes.push( EnemyTypes.NORMAL_WORD_ENEMY_TYPE, EnemyTypes.BOMB_ENEMY_TYPE );
			secondsToReachCity = 55;
			secondsToAccelBy = .5;
			tickThresholdForAcceleration = this.secondsToTicks(50);
			numTimesToAccelerate = 10;
			bonusEnemySecondsToOffscreen = 0;
			shouldShowPowerUp = false;
			minEnemyCountThresholdForShowingPowerUp = 0;
			maxEnemyCountThresholdForShowingPowerUp = 0;
			numEnemiesToCreate = 10;
			secondsForBombToReachCity = 5;
			startMessages = new Array();
			startMessages.push( "A new enemy has appeared!\n\nCharacter bombs do minimal damage but travel very fast. See if you can destroy them all before they hit your city." );
			startMessages.push( "Note, you can pause the game and change sound volume by pressing the Escape (Esc) key." );
			
			this.levels.push( createLevelAttr() );
			
			//Level 3
			shouldAimEnemies = true;
			tickThresholdForAddingEnemies = decreaseTickThresholdForAddingEnemies();
			enemyCountThresholdForAimingEnemies = 10;
			tickThresholdUsingSpecialAbilities = this.secondsToTicks(30);
			shouldShowBonusEnemy = false;
			minTickThresholdForShowingBonusEnemy = 0;
			maxTickThresholdForShowingBonusEnemy = 0;
			enemyTypes = new Array();
			enemyTypes.push( EnemyTypes.NORMAL_WORD_ENEMY_TYPE, EnemyTypes.BOMB_ENEMY_TYPE, EnemyTypes.DROP_LETTER_WORD_ENEMY_TYPE );
			secondsToReachCity = 50;
			secondsToAccelBy = 1;
			tickThresholdForAcceleration = this.secondsToTicks(40);
			numTimesToAccelerate = 8;
			bonusEnemySecondsToOffscreen = 0;
			shouldShowPowerUp = true;
			minEnemyCountThresholdForShowingPowerUp = 5;
			maxEnemyCountThresholdForShowingPowerUp = 10;
			availablePowerUps = new Array();
			availablePowerUps.push( PowerUpTypes.PAUSE_POWERUP );			
			numEnemiesToCreate = 10 + Math.floor(Math.random() * 4) + 2;
			secondsForBombToReachCity = 4;
			startMessages = new Array();
			startMessages.push( "Words and character bombs have combined to form a frightful new enemy. These enemies drop their letters at random, creating an added threat to your city and forcing you to fill in the blanks." );
			startMessages.push( "To help, you can use PAUSE power ups. When a P appears in the upper right hand corner of the screen, use the F1, F2 and F3 keys to activate the power up and pause all enemies for five seconds." );
												
			this.levels.push( createLevelAttr() );

			//Level 4
			shouldAimEnemies = true;
			tickThresholdForAddingEnemies = decreaseTickThresholdForAddingEnemies();
			enemyCountThresholdForAimingEnemies = 9;
			tickThresholdUsingSpecialAbilities = this.secondsToTicks(20);
			shouldShowBonusEnemy = false;
			minTickThresholdForShowingBonusEnemy = 0;
			maxTickThresholdForShowingBonusEnemy = 0;
			enemyTypes = new Array();
			enemyTypes.push( EnemyTypes.NORMAL_WORD_ENEMY_TYPE, EnemyTypes.BOMB_ENEMY_TYPE, EnemyTypes.DROP_LETTER_WORD_ENEMY_TYPE, EnemyTypes.MISSING_LETTER_WORD_ENEMY_TYPE );
			secondsToReachCity = 45;
			secondsToAccelBy = 1.5;
			tickThresholdForAcceleration = this.secondsToTicks(30);
			numTimesToAccelerate = 4;
			bonusEnemySecondsToOffscreen = 0;
			shouldShowPowerUp = true;
			minEnemyCountThresholdForShowingPowerUp = 5;
			maxEnemyCountThresholdForShowingPowerUp = 10;
			availablePowerUps = new Array();
			availablePowerUps.push( PowerUpTypes.PAUSE_POWERUP, PowerUpTypes.REVEAL_POWERUP );	
			numEnemiesToCreate = 20 + Math.floor(Math.random() * 4) + 2;
			secondsForBombToReachCity = 3;
			startMessages = new Array();
			startMessages.push( "Your tight defense has angered the invaders and forced them to create their most dangerous enemy yet. This new word STARTS with several blank characters that you must fill in, stressing both your vocabulary and spelling skills!" );
			startMessages.push( "But luckily, you also gain access to a new power up. The REVEAL power up, designated by an R, reveals all missing letters for all the words on the screen. Use them wisely!" );
												
			this.levels.push( createLevelAttr() );
			
			//Level 5
			shouldAimEnemies = true;
			tickThresholdForAddingEnemies = decreaseTickThresholdForAddingEnemies();
			enemyCountThresholdForAimingEnemies = 8;
			tickThresholdUsingSpecialAbilities = this.secondsToTicks(10);
			shouldShowBonusEnemy = true;
			minTickThresholdForShowingBonusEnemy = this.secondsToTicks(15);
			maxTickThresholdForShowingBonusEnemy = this.secondsToTicks(30);
			secondsToReachCity = 40;
			secondsToAccelBy = 2;
			tickThresholdForAcceleration = this.secondsToTicks(20);
			numTimesToAccelerate = 2;
			bonusEnemySecondsToOffscreen = 10;
			shouldShowPowerUp = true;
			minEnemyCountThresholdForShowingPowerUp = 5;
			maxEnemyCountThresholdForShowingPowerUp = 10;
			availablePowerUps = new Array();
			availablePowerUps.push( PowerUpTypes.PAUSE_POWERUP, PowerUpTypes.REVEAL_POWERUP, PowerUpTypes.EXPLODE_POWERUP );			
			numEnemiesToCreate = 30 + Math.floor(Math.random() * 4) + 2;
			secondsForBombToReachCity = 3;
			startMessages = new Array();
			startMessages.push( "Keep up the good work! As the battle rages on, the invaders will try to sneak by a non-threatening enemy which flies across the screen. Destroying this enemy delivers extra bonus points." );
			startMessages.push( "If things get too chaotic, use an EXPLODE power up, marked by the letter E to destroy all visible enemies." );
												
			this.levels.push( createLevelAttr() );
			
			//Level 6
			this.updateLevelAttributes();
			
			startMessages = new Array();
			startMessages.push( "You will be rewarded for reaching " + this.rewardedLevel.toString() + " levels and reaching " + this.rewardedScore.toString() + " points, so don't stop now!" );

			this.levels.push( createLevelAttr() );
		}
		
		public function createLevel(scoreManager:IScoreManager, levelNum:int):ILevel
		{
			var levelAttr:LevelAttributes = this.getLevelAttributes(levelNum);
			
			return new Level( this.enemyFactory, scoreManager, this.city, this.playAreaWidth, this.playAreaHeight, levelAttr, this.enemyStartY, powerUpManagerFactory );
		}
		
		public function getLevelAttributes( levelNum:int ):LevelAttributes
		{
			var levelIndex:int = levelNum - 1;

			if ( levelIndex >= this.levels.length )
			{
				this.updateLevelAttributes();
				
				startMessages = new Array();		
				startMessages.push(this.randomContinuationMessages[Math.floor(Math.random() * this.randomContinuationMessages.length)]);			
				
				return this.createLevelAttr();
			}
			
			return this.levels[levelIndex];
		}
		
		private function updateLevelAttributes():void
		{
			if ( tickThresholdForAddingEnemies > this.minTickThresholdForAddingEnemies )
				tickThresholdForAddingEnemies = decreaseTickThresholdForAddingEnemies();
			
			if ( enemyCountThresholdForAimingEnemies > minEnemyCountThresholdForAimingEnemies )
				enemyCountThresholdForAimingEnemies = enemyCountThresholdForAimingEnemies - 1;
			
			if ( secondsToReachCity > this.minSecondsToReachCity )
				secondsToReachCity -= 5;
				
			secondsToAccelBy = 3;

			if ( bonusEnemySecondsToOffscreen > minBonusEnemySecondsToOffscreen )
				bonusEnemySecondsToOffscreen -= 1;
						
			numEnemiesToCreate += Math.floor(Math.random() * 8) + 5;
		}
		
		private function secondsToTicks( seconds:Number ):int
		{
			return seconds * this.gameTicksPerSecond;
		}
		
		private function ticksToSeconds( ticks:int ):Number
		{
			return ticks / this.gameTicksPerSecond;
		}
		
		private function decreaseTickThresholdForAddingEnemies():int
		{
			return this.secondsToTicks( this.ticksToSeconds(tickThresholdForAddingEnemies) - .1 );
		}
		
		private function createLevelAttr():LevelAttributes
		{
			return new LevelAttributes(	gameTicksPerSecond, 
										this.playAreaWidth, 
										distanceToCity, 
										shouldAimEnemies,
										tickThresholdForAddingEnemies, 
										enemyCountThresholdForAimingEnemies,
										tickThresholdUsingSpecialAbilities,
										shouldShowBonusEnemy,
										minTickThresholdForShowingBonusEnemy,
										maxTickThresholdForShowingBonusEnemy,
										enemyTypes,
										secondsToReachCity,
										secondsToAccelBy,
										tickThresholdForAcceleration,
										numTimesToAccelerate,
										bonusEnemySecondsToOffscreen,
										shouldShowPowerUp,
										minEnemyCountThresholdForShowingPowerUp,
										maxEnemyCountThresholdForShowingPowerUp,
										availablePowerUps,
										numEnemiesToCreate,
										secondsForBombToReachCity,
										startMessages );
		}
	}
	
}