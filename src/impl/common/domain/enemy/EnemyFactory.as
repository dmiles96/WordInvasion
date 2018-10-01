package impl.common.domain.enemy 
{
	import flash.utils.Dictionary;
	import iface.common.domain.dictionary.IDictionary;
	import iface.common.domain.enemy.CharacterExclusionMap;
	import iface.common.domain.enemy.IBombCreator;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyFactory;
	import iface.common.domain.enemy.IEnemySizeComputer;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.ISpecialEnemyNotifier;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.enemy.IWord;
	import iface.common.domain.IClipper;
	import iface.common.domain.ICollisionDetector;
	import iface.common.domain.enemy.EnemyTypes;
	
	/**
	 * ...
	 * @author ...
	 */
	public class EnemyFactory implements IEnemyFactory
	{
		private var dictionary:IDictionary = null;
		private var collisionDetector:ICollisionDetector = null;
		private var clipper:IClipper = null;
		private var enemySizeComputer:IEnemySizeComputer = null;
		private var ticksToExplode:int = 0;
		private var playAreaWidth:int = 0;
		private var millisecondsPerTick:int = 0;
		
		public function EnemyFactory( dictionary:IDictionary, enemySizeComputer:IEnemySizeComputer, ticksToExplode:int, playAreaWidth:int, millisecondsPerTick:int ) 
		{
			this.dictionary = dictionary;
			this.collisionDetector = collisionDetector;
			this.clipper = clipper;
			this.enemySizeComputer = enemySizeComputer;
			this.ticksToExplode = ticksToExplode;
			this.millisecondsPerTick = millisecondsPerTick;
			this.playAreaWidth = playAreaWidth;
		}
		
		public function createEnemy( enemyType:int, positioner:IPositioner, collisionDetector:ICollisionDetector, clipper:IClipper, velocityComputer:IVelocityComputer, charExclusionMap:CharacterExclusionMap, specialEnemyNotifier:ISpecialEnemyNotifier, notificationsPerSecond:int, bombCreator:IBombCreator ):IEnemy
		{
			var newEnemy:IEnemy = null;
			
			if ( enemyType == EnemyTypes.BOMB_ENEMY_TYPE )
			{
				var chosenFirstChar:String = charExclusionMap.randomAvailableChar();

				if ( chosenFirstChar != null )
				{
					newEnemy = this.createBombInternal( chosenFirstChar, positioner, collisionDetector, velocityComputer, this.enemySizeComputer.computeWidth( chosenFirstChar ), this.enemySizeComputer.computeHeight( chosenFirstChar ) );
				}
			}
			else
			{
				var chosenWord:String = chooseWordFromDictionary(charExclusionMap);;

				if ( chosenWord != null )
				{
					if ( enemyType == EnemyTypes.NORMAL_WORD_ENEMY_TYPE )
					{
						newEnemy = this.createNormalWord( chosenWord, positioner, collisionDetector, velocityComputer, this.enemySizeComputer.computeWidth( chosenWord ), this.enemySizeComputer.computeHeight( chosenWord ) );
					}
					else if (enemyType == EnemyTypes.BONUS_WORD_ENEMY_TYPE)
					{
						newEnemy = this.createBonusWord( chosenWord, positioner, clipper, velocityComputer, this.enemySizeComputer.computeWidth( chosenWord ), this.enemySizeComputer.computeHeight( chosenWord ) );
					}
					else if (enemyType == EnemyTypes.DROP_LETTER_WORD_ENEMY_TYPE)
					{
						newEnemy = this.createDropLetterWord( chosenWord, positioner, collisionDetector, velocityComputer, this.enemySizeComputer.computeWidth( chosenWord ), this.enemySizeComputer.computeHeight( chosenWord ), specialEnemyNotifier, notificationsPerSecond, bombCreator );
					}
					else if (enemyType == EnemyTypes.MISSING_LETTER_WORD_ENEMY_TYPE)
					{
						newEnemy = this.createMissingLetterWord( chosenWord, positioner, collisionDetector, velocityComputer, this.enemySizeComputer.computeWidth( chosenWord ), this.enemySizeComputer.computeHeight( chosenWord ) );
					}	
				}
			}

			return newEnemy;
		}
		
		public function createBomb( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, charExclusionMap:CharacterExclusionMap ):IEnemy
		{
			var newEnemy:IEnemy = null;
			var chosenFirstChar:String = data.charAt(0);
			
			if ( !charExclusionMap.isExcluded( chosenFirstChar ))
			{
				newEnemy = this.createBombInternal( chosenFirstChar, positioner, collisionDetector, velocityComputer, this.enemySizeComputer.computeWidth( chosenFirstChar ), this.enemySizeComputer.computeHeight( chosenFirstChar ) );
			}
			
			return newEnemy;
		}
		
		private function createNormalWord( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int ):IWord
		{
			return new Word(data, positioner, collisionDetector, velocityComputer, width, height, this.ticksToExplode);
		}
		
		private function createBombInternal( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int ):IEnemy
		{
			return new Bomb(data, positioner, collisionDetector, velocityComputer, width, height, this.ticksToExplode);
		}
		
		private function createBonusWord( data:String, positioner:IPositioner, clipper:IClipper, velocityComputer:IVelocityComputer, width:int, height:int ):IEnemy
		{
			return new BonusWord(data, positioner, clipper, velocityComputer, width, height, this.ticksToExplode, this.playAreaWidth, this.millisecondsPerTick);
		}
		
		private function createDropLetterWord( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int, specialEnemyNotifier:ISpecialEnemyNotifier, notificationsPerSecond:int, bombCreator:IBombCreator ):IEnemy
		{
			return new DropLetterWord(data, positioner, collisionDetector, velocityComputer, width, height, specialEnemyNotifier, notificationsPerSecond, bombCreator, this.ticksToExplode );
		}
		
		private function createMissingLetterWord( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int ):IEnemy
		{
			return new MissingLetterWord(data, positioner, collisionDetector, velocityComputer, width, height, this.ticksToExplode);
		}
		
		private function chooseWordFromDictionary(charExclusionMap:CharacterExclusionMap):String
		{
			var chosenWord:String = null;
			var chosenFirstChar:String = charExclusionMap.randomAvailableChar();
			
			if ( chosenFirstChar != null )
			{
				var capitalized:Boolean = isCapitalized(chosenFirstChar);
				
				if ( capitalized )
				{
					if ( !this.dictionary.contains( chosenFirstChar ))
					{
						chosenFirstChar = chosenFirstChar.toLocaleLowerCase();
					}
				}
				
				chosenWord = this.dictionary.lookupRandomWord(chosenFirstChar);
				
				if ( capitalized )
				{
					var capitalizedLetter:String = chosenWord.charAt(0).toLocaleUpperCase();
					
					chosenWord = capitalizedLetter.concat( chosenWord.substring(1) );
				}
			}
			
			return chosenWord;
		}

		private function isCapitalized( capitalizedChar:String ):Boolean
		{
			var lowerCaseChar:String = capitalizedChar.toLocaleLowerCase();
			
			return lowerCaseChar != capitalizedChar;
		}
	}
}