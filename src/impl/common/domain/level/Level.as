package impl.common.domain.level 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import iface.common.domain.city.ICityDestroyedListener;
	import iface.common.domain.CommandTypes;
	import iface.common.domain.city.ICity;
	import iface.common.domain.enemy.CharacterExclusionMap;
	import iface.common.domain.enemy.EnemyDirection;
	import iface.common.domain.enemy.IBombCreator;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyFactory;
	import iface.common.domain.enemy.ILetterHider;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.ISpecialEnemyNotifier;
	import iface.common.domain.enemy.ISpecialEnemy;
	import iface.common.domain.IClipper;
	import iface.common.domain.level.ILevel;
	import iface.common.domain.level.ILevelCompleteListener;
	import iface.common.domain.level.ILevelListener;
	import iface.common.domain.powerup.IPowerUp;
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.domain.powerup.IPowerUpManagerFactory;
	import iface.common.domain.powerup.ISpecialPowerUp;
	import iface.common.domain.powerup.ISpecialPowerUpNotifier;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.score.IScoreManager;
	import iface.common.domain.enemy.EnemyTypes;
	import iface.common.domain.enemy.MoveResults;
	import iface.common.domain.enemy.CharacterMatchResults;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Level implements ICityDestroyedListener, ISpecialPowerUpNotifier, IPowerUpCommandExecutor, IBombCreator, ISpecialEnemyNotifier, IClipper, IPositioner, ILevel
	{
		private var enemies:Array = new Array();
		private var enemyFactory:IEnemyFactory = null;
		private var levelListeners:Array = new Array();
		private var currentEnemy:IEnemy = null;
		private var firstChars:Dictionary = new Dictionary();
		private var scoreManager:IScoreManager = null;
		private var city:ICity = null;
		private var playAreaWidth:int = 0;
		private var charExclustionMap:CharacterExclusionMap = new CharacterExclusionMap();
		private var playAreaHeight:int = 0;
		private var specialEnemies:Array = new Array();
		private var centerPositioner:ExactPositioner = new ExactPositioner();
		private var levelAttr:LevelAttributes = null;
		private var addEnemyCounter:int = 0;
		private var enemyAimCounter:int = 0;
		private var showBonusEnemyCounter:int = 0;
		private var enemyAccelerationCounter:int = 0;
		private var timesAcceleratedCounter:int = 0;
		private var enemyStartY:int = 0;
		private var powerUpManager:IPowerUpManager = null;
		private var showPowerUpCounter:int = 0;
		private var showingBonusEnemy:Boolean = false;
		private var enemiesPaused:Boolean = false;
		private var specialPowerUps:Array = new Array();
		private var enemiesCreatedCounter:int = 0;
		private var levelCompleteListeners:Array = new Array();
		private var queuedEnemy:IEnemy = null;
		private var lastEnemyAddedOnTick:IEnemy = null;
		private var explodingEnemies:Array = new Array();
		private var enemyDestructionRecs:Dictionary = new Dictionary();
		private var firingProjectiles:Array = new Array();
		
		public function Level( enemyFactory:IEnemyFactory, scoreManager:IScoreManager, city:ICity, playAreaWidth:int, playAreaHeight:int, levelAttr:LevelAttributes, enemyStartY:int, powerUpManagerFactory:IPowerUpManagerFactory)
		{
			this.enemyFactory = enemyFactory;
			this.scoreManager = scoreManager;
			this.city = city;
			this.playAreaWidth = playAreaWidth;
			this.playAreaHeight = playAreaHeight;
			this.levelAttr = levelAttr;
			this.enemyStartY = enemyStartY;
			
			this.addEnemyCounter = this.levelAttr.getTickThresholdForAddingEnemies();
			this.powerUpManager = powerUpManagerFactory.createPowerUpManager(this, this);
			
			this.city.addCityDestroyedListener( this );
		}

		public function getCity():ICity
		{
			return this.city;
		}
		
		public function getPowerUpManager():IPowerUpManager
		{
			return this.powerUpManager;
		}
		
		public function changeAttributes( newLevelAttributes:LevelAttributes ):void
		{
			this.levelAttr = newLevelAttributes;

			this.addEnemyCounter = this.levelAttr.getTickThresholdForAddingEnemies();
			this.enemyAimCounter = 0;
			this.showBonusEnemyCounter = 0;
			this.enemyAccelerationCounter = 0;
			this.timesAcceleratedCounter = 0;
			this.showPowerUpCounter = 0;
			this.showingBonusEnemy = false;
			this.enemiesPaused = false;
			this.enemiesCreatedCounter = 0;
			this.charExclustionMap.resortCharacters();
		}
		
		public function tick(tickDelta:int):void
		{
			if ( (this.enemies.length == 0) && (this.explodingEnemies.length == 0) && (this.levelAttr.isAtMaxEnemiesToCreate(this.enemiesCreatedCounter)) )
			{
				this.fireLevelWonEvent();
				
				return;
			}
			
			this.tickExplodingEnemies(tickDelta);
			this.notifySpecialPowerUps(tickDelta);
			this.moveProjectiles(tickDelta);
			
			if ( !this.enemiesPaused )
			{
				this.notifyEnemies(tickDelta);
				this.moveEnemies(tickDelta);
				
				if ( this.levelAttr.isAtThresholdForAddingEnemies( this.addEnemyCounter ))
				{
					if ( this.createEnemyOnTick() )
					{
						if( this.levelAttr.getShouldAimEnemies() )
							this.enemyAimCounter++;

						if ( this.levelAttr.getShouldShowPowerUp() )
							this.showPowerUpCounter++;
							
						this.addEnemyCounter = 0;
					}
				}
				else
				{
					this.addEnemyCounter += tickDelta;
				}
				
				if ( this.timesAcceleratedCounter <= this.levelAttr.getNumTimesToAccelerate() )
				{
					if ( this.levelAttr.getTickThresholdForAcceleration() < this.enemyAccelerationCounter )
					{
						this.levelAttr.accelerate();
						this.enemyAccelerationCounter = 0;
						this.timesAcceleratedCounter++;
					}
					else
					{
						this.enemyAccelerationCounter += tickDelta;
					}
				}
				
				if ( this.levelAttr.getShouldShowBonusEnemy() )
				{
					this.showBonusEnemyCounter++;
				}
			}
		}

		public function inputAlphaNumeric( typedChar:String ):void
		{
			if ( this.currentEnemy == null )
			{
				this.currentEnemy = this.firstChars[typedChar];
				
				if ( this.currentEnemy == null ) 
				{
					this.scoreManager.scoreNonExsistantLetter();
					this.fireTypoEvent();
				}
			}

			if ( this.currentEnemy != null )
			{
				var matchResult:int = this.currentEnemy.matchNextChar(typedChar);
				
				if ( matchResult == CharacterMatchResults.MATCH_FAILURE )
				{
					this.scoreManager.scoreTypo();
					this.fireTypoEvent();
					this.currentEnemy = null;
				}
				else if ( matchResult == CharacterMatchResults.MATCH_COMPLETE )
				{
					this.handleTargetedEnemy( this.currentEnemy );
				}
			}
		}
		
		public function inputCommand( command:int ):void
		{
			if ( command == CommandTypes.USE_POWERUP_ONE_COMMAND )
			{
				this.powerUpManager.usePowerUp( 0 );
			}
			else if ( command == CommandTypes.USE_POWERUP_TWO_COMMAND )
			{
				this.powerUpManager.usePowerUp( 1 );
			}
			else if ( command == CommandTypes.USE_POWERUP_THREE_COMMAND )
			{
				this.powerUpManager.usePowerUp( 2 );
			}
		}
		
		public function addLevelListener( levelListener:ILevelListener ):void
		{
			this.levelListeners.push( levelListener );
		}
		
		public function addLevelCompleteListener( levelCompleteListener:ILevelCompleteListener ):void
		{
			this.levelCompleteListeners.push( levelCompleteListener );
		}
		
		public function repairCity():void
		{
			this.city.repair();
		}
		
		public function addRandomPowerUp():Boolean
		{
			if ( this.levelAttr.getShouldShowPowerUp() )
			{
				this.addPowerUp();
				
				return true;
			}
			
			return false;
		}
		
		public function isOffScreen( x:int, y:int, width:int, height:int ):Boolean
		{
			if ( x < -width )
			{
				return true;
			}
			else if ( x > playAreaWidth )
			{
				return true;
			}
			
			return false;
		}
		
		public function initializePosition( direction:int, position:Point, width:int, height:int ):void
		{
			if ( direction == EnemyDirection.DOWN_DIRECTION )
			{
				var enemyStartX:int = 0;
				var enemyPositioned:Boolean = false;
				
				if ( this.levelAttr.isAtEnemyCountForAimThreshold(this.enemyAimCounter) )
				{
					if ( Math.round( Math.random() ) == 1 )
					{
						enemyStartX = city.getVulnerableLocation() - (width / 2)
						
						if ( (enemyStartX + width) > this.playAreaWidth )
							enemyStartX = this.playAreaWidth - width;
						else if ( enemyStartX < 0 )
							enemyStartX = 0;
							
						enemyPositioned = true;
					}
					
					this.enemyAimCounter = 0;
				}
				
				if( !enemyPositioned )
				{
					enemyStartX = Math.floor( Math.random() * (this.playAreaWidth - width) );
				}

				position.x = enemyStartX;
				position.y = enemyStartY;
			}
			else 
			{
				var maxStartY:int = playAreaHeight / 2;
				
				if ( direction == EnemyDirection.LEFT_DIRECTION )
				{
					var leftEnemyStartY:int = Math.floor( Math.random() * maxStartY ) + enemyStartY;

					if ( leftEnemyStartY > maxStartY )
						leftEnemyStartY = maxStartY;
						
					position.y = leftEnemyStartY;
					position.x = this.playAreaWidth;
				}
				else if ( direction == EnemyDirection.RIGHT_DIRECTION )
				{
					var rightEnemyStartY:int = Math.floor( Math.random() * maxStartY ) + enemyStartY;

					if ( rightEnemyStartY > maxStartY )
						rightEnemyStartY = maxStartY;
						
					position.y = rightEnemyStartY;
					position.x = -width;
				}				
			}
		}
		
		private function notifyEnemies( notificationDelta:int ):void
		{
			for each( var specialEnemy:ISpecialEnemy in this.specialEnemies )
			{
				specialEnemy.notify( notificationDelta );
			}
		}
		
		public function registerSpecialEnemyForNotification( specialEnemy:ISpecialEnemy ):void
		{
			this.specialEnemies.push( specialEnemy );
		}
		
		public function unregisterSpecialEnemyFromNotification( specialEnemy:ISpecialEnemy ):void
		{
			this.specialEnemies.splice( specialEnemies.indexOf( specialEnemy ), 1 );
		}
		
		public function createBomb( data:String, x:int, y:int ):Boolean
		{
			this.centerPositioner.updatePosition( x, y );
			
			var newEnemy:IEnemy = this.enemyFactory.createBomb( data, this.centerPositioner, this.city, this.levelAttr, charExclustionMap );
			
			this.addEnemy( newEnemy );
			
			return newEnemy != null;
		}		

		public function registerSpecialPowerUpForNotification( specialPowerUp:IPowerUp ):void
		{
			this.specialPowerUps.push( specialPowerUp );
		}
		
		public function unregisterSpecialPowerUpFromNotification( specialPowerUp:IPowerUp ):void
		{
			this.specialPowerUps.splice( this.specialPowerUps.indexOf( specialPowerUp ), 1 );
		}

		private function notifySpecialPowerUps( notificationDelta:int ):void
		{
			for each( var specialPowerUp:ISpecialPowerUp in this.specialPowerUps )
			{
				specialPowerUp.notify( notificationDelta );
			}			
		}
		
		public function destroyEnemies():void
		{
			var numEnemies:int = this.enemies.length;
			
			for ( var enemyIndex:int = 0; enemyIndex < numEnemies; enemyIndex++ )
			{
				var enemy:IEnemy = this.enemies.shift();
				
				this.handleEnemyExplosion( enemy, true );
			}
		}
		
		public function pauseEnemies():void
		{
			this.enemiesPaused = true;
		}
		
		public function unpauseEnemies():void
		{
			this.enemiesPaused = false;
		}
		
		public function revealLetters():void
		{
			for each( var enemy:IEnemy in this.enemies )
			{
				var letterHider:ILetterHider = enemy as ILetterHider;
				
				if ( letterHider != null )
					letterHider.revealAllLetters();
			}
		}
		
		public function cityDestroyed():void
		{
			this.fireLevelLostEvent();
		}
		
		public function getStartMessages():Array
		{
			return this.levelAttr.getStartMessages();
		}
		
		private function createEnemyOnTick():Boolean
		{
			var enemyCreated:Boolean = false;
			
			if ( !this.levelAttr.isAtMaxEnemiesToCreate( this.enemiesCreatedCounter ))
			{
				//first check to see if we should create a bonus enemy
				if ( this.levelAttr.getShouldShowBonusEnemy() && (this.showingBonusEnemy == false) )
				{
					if ( this.levelAttr.isAtTickThresholdForShowingBonusEnemy( this.showBonusEnemyCounter ))
					{
						if ( Math.round( Math.random() ) == 1 )
						{
							enemyCreated = this.createBonusEnemy();
							
							if ( enemyCreated )
							{
								this.levelAttr.generateTickThresholdForShowingBonusEnemy();
								this.showingBonusEnemy = true;
							}
								
							this.showBonusEnemyCounter = 0;
						}
					}
				}
				
				//if not, create a random enemy
				if ( enemyCreated == false )
				{
					var newEnemy:IEnemy = null;
				
					if ( this.queuedEnemy == null )
					{
						newEnemy = this.createEnemy( this.levelAttr.getRandomEnemyType() );
					}
					else
					{
						newEnemy = this.queuedEnemy;
					}
					
					enemyCreated = ( newEnemy != null );
					
					if ( enemyCreated )
					{
						if( !this.queueOverlappedEnemies(newEnemy) )
						{
							this.addEnemy( newEnemy );
							this.lastEnemyAddedOnTick = newEnemy;
							this.queuedEnemy = null;
						}
					}					
				}	
				
				
				//if a new enemy of any type was created, increase the counter
				if ( enemyCreated )
					this.enemiesCreatedCounter++;
			}
			
			return enemyCreated;
		}
		
		private function createBonusEnemy():Boolean
		{
			var newEnemy:IEnemy = this.createEnemy( EnemyTypes.BONUS_WORD_ENEMY_TYPE );
			
			this.addEnemy( newEnemy );
			
			return newEnemy != null;
		}

		private function createEnemy( enemyType:int ):IEnemy
		{
			return enemyFactory.createEnemy(enemyType, this, this.city, this, this.levelAttr, charExclustionMap, this, this.levelAttr.getTickThresholdUsingSpecialAbilities(), this );
		}
		
		private function queueOverlappedEnemies( newEnemy:IEnemy ):Boolean
		{
			if ( (this.lastEnemyAddedOnTick != null) && (newEnemy != null) )
			{
				if ( this.lastEnemyAddedOnTick.getRect().intersects( newEnemy.getRect() ))
				{
					this.queuedEnemy = newEnemy;
					return true;
				}
			}
			
			return false;
		}
		
		private function addEnemy( newEnemy:IEnemy ):void
		{
			if ( newEnemy != null )
			{
				this.enemies.push(newEnemy);
				this.firstChars[newEnemy.getFirstChar()] = newEnemy;
				this.charExclustionMap.excludeChar(newEnemy.getFirstChar());
				
				fireEnemyCreationEvent(newEnemy);
			}
		}
		
		private function moveEnemies( moveFactor:int ):void
		{
			var numEnemies:int = this.enemies.length;
			
			for ( var enemyIndex:int = 0; enemyIndex < numEnemies; enemyIndex++ )
			{
				var enemy:IEnemy = this.enemies.shift();
				var moveResult:int = enemy.move(moveFactor);
				
				if ( moveResult == MoveResults.MOVE_SUCCESSFUL )
				{
					this.enemies.push( enemy );
				}
				else
				{
					if ( moveResult == MoveResults.MOVE_FAILURE_COLLISION )
					{
						this.handleEnemyExplosion( enemy, false );
					}
					else if ( moveResult == MoveResults.MOVE_FAILURE_OFFSCREEN )
					{
						this.handleEnemyDeath( enemy, false );
					}
				}
			}
			
			this.fireEnemiesMovedEvent(numEnemies);
		}
		
		private function handleEnemyExplosion( enemy:IEnemy, usedPowerUp:Boolean ):void
		{
			enemy.explode();
			
			if( !enemy.isTargeted() )
				this.clearEnemyTracking(enemy);
				
			this.explodingEnemies.push( enemy );
			this.enemyDestructionRecs[enemy] = new EnemyDestructionRecord( usedPowerUp );
		}
		
		private function handleEnemyDeath( enemy:IEnemy, usedPowerUp:Boolean ):void
		{
			enemy.die();
			
			if ( !enemy.isExploded() )
			{
				this.clearEnemyTracking(enemy);
			}
			
			if ( enemy.isDestroyed() )
			{
				this.scoreManager.scoreEnemyDeath( enemy );
				
				if ( !usedPowerUp )
				{
					if ( levelAttr.isAtEnemyCountThresholdForShowingPowerUp( this.showPowerUpCounter ))
					{
						if ( Math.round( Math.random() ) == 1 )
						{
							this.addPowerUp();
							this.levelAttr.generateTickThresholdForShowingPowerUp();
						}
						
						this.showPowerUpCounter = 0;
					}
				}
			}
			
			this.fireEnemyDeathEvent(enemy);
		}
		
		private function handleTargetedEnemy( enemy:IEnemy ):void
		{
			this.clearEnemyTracking( enemy );			
			this.firingProjectiles.push( this.city.fireProjectile( enemy, enemy.getY() ));
		}

		private function tickExplodingEnemies( tickDelta:Number ):void
		{
			var numExplodingEnemies:int = this.explodingEnemies.length;
			
			for ( var enemyIndex:int = 0; enemyIndex < numExplodingEnemies; enemyIndex++ )
			{
				var enemy:IEnemy = this.explodingEnemies.shift();
				var stillExploding:Boolean = enemy.tickExplosion( tickDelta );
				
				if ( stillExploding )
				{
					this.explodingEnemies.push( enemy );
				}
				else
				{
					var enemyDestructionRec:EnemyDestructionRecord = this.enemyDestructionRecs[enemy];
					this.handleEnemyDeath( enemy, enemyDestructionRec.isPowerUpDeath() );
					delete this.enemyDestructionRecs[enemy];
				}
			}			
		}
		
		private function clearEnemyTracking( enemy:IEnemy ):void
		{
			this.firstChars[enemy.getFirstChar()] = null;
			this.charExclustionMap.includeChar(enemy.getFirstChar());
			
			if ( this.currentEnemy == enemy )
			{
				this.currentEnemy = null;
			}
			
			if ( this.lastEnemyAddedOnTick == enemy )
			{
				this.lastEnemyAddedOnTick = null;
			}
			
			if ( enemy.getType() == EnemyTypes.BONUS_WORD_ENEMY_TYPE )
			{
				this.showingBonusEnemy = false;
			}
		}
			
		private function moveProjectiles(moveFactor:Number):void
		{
			var numProjectiles:int = this.firingProjectiles.length;
			var numEnemiesHit:int = 0;
			
			for ( var projectileIndex:int = 0; projectileIndex < numProjectiles; projectileIndex++ )
			{
				var projectile:IProjectile = this.firingProjectiles.shift();
				
				if ( projectile.move( moveFactor ) == false )
				{
					numEnemiesHit++;
				}
				else
				{
					this.firingProjectiles.push( projectile );
				}
			}

			var numEnemies:int = this.enemies.length;
			
			for ( var enemyIndex:int = 0; (enemyIndex < numEnemies) && (numEnemiesHit > 0); enemyIndex++ )
			{
				var enemy:IEnemy = this.enemies.shift();
				
				if ( enemy.isDestroyed() )
				{
					numEnemiesHit--;
					this.handleEnemyExplosion(enemy, false);
				}
				else
				{
					this.enemies.push( enemy );
				}
			}
		}
		
		private function addPowerUp():void
		{
			this.powerUpManager.addPowerUp( levelAttr.getRandomPowerUpType() );
		}
		
		private function fireEnemyCreationEvent( enemy:IEnemy ):void
		{
			if( this.levelListeners[0] != null )
				this.levelListeners[0].enemyCreated(enemy);
		}

		private function fireEnemyDeathEvent( enemy:IEnemy ):void
		{
			if( this.levelListeners[0] != null )
				this.levelListeners[0].enemyDeath(enemy);
		}

		private function fireLevelWonEvent():void
		{
			if ( this.levelCompleteListeners[0] != null )
				this.levelCompleteListeners[0].levelWon();
		}

		private function fireLevelLostEvent():void
		{
			if ( this.levelCompleteListeners[0] != null )
				this.levelCompleteListeners[0].levelLost();
		}
		
		private function fireEnemiesMovedEvent( numEnemiesMoved:int ):void
		{
			if ( this.levelListeners[0] != null )
				this.levelListeners[0].enemiesMoved(numEnemiesMoved);
		}
		
		private function fireTypoEvent():void
		{
			if ( this.levelListeners[0] != null )
				this.levelListeners[0].typo();			
		}
	}	
}