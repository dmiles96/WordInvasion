package impl.common.domain.enemy 
{
	import iface.common.domain.Dimension;
	import iface.common.domain.enemy.CharacterMatchResults;
	import iface.common.domain.enemy.EnemyTypes;	
	import iface.common.domain.enemy.IBombCreator;
	import iface.common.domain.enemy.IDropLetterWord;
	import iface.common.domain.enemy.IDropLetterWordListener;
	import iface.common.domain.enemy.IEnemyFactory;
	import iface.common.domain.enemy.IEnemyListener;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.ISpecialEnemy;
	import iface.common.domain.enemy.ISpecialEnemyNotifier;
	import iface.common.domain.enemy.ISpecialEnemyNotifier;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.ICollisionDetector;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DropLetterWord extends FallingEnemy implements IDropLetterWord
	{
		private var specialEnemyNotifier:ISpecialEnemyNotifier = null;
		private var notificationsPerSecond:int = 0;
		private var notificationCounter:int = 0;
		private var bombCreator:IBombCreator = null;
		private var letterToDropIndex:int = 0;
		private var dropLetterWordListeners:Array = new Array();
		private var droppedLetterCounter:int = 0;
		private var registered:Boolean = true;
		private var maxLettersToDrop:int = 0;
		private var revealed:Boolean = false;
		private var availableLettersToDrop:Array = new Array();
		private var droppedLetterIndexes:Array = new Array();
		
		public function DropLetterWord(data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int, specialEnemyNotifier:ISpecialEnemyNotifier, notificationsPerSecond:int, bombCreator:IBombCreator, ticksToExplode:int) 
		{
			super(data, positioner, collisionDetector, velocityComputer, width, height, ticksToExplode, velocityComputer.computeFallingEnemyVelocity(height));

			this.specialEnemyNotifier = specialEnemyNotifier;
			this.notificationsPerSecond = notificationsPerSecond;
			this.bombCreator = bombCreator;

			this.chooseAvailableLettersToDrop();

			this.maxLettersToDrop = Math.floor( availableLettersToDrop.length / 2 );
			this.letterToDropIndex = this.chooseLetterIndexToDrop();
			this.specialEnemyNotifier.registerSpecialEnemyForNotification(this);
		}
		
		public function notify( notificationDelta:int ):void
		{
			notificationCounter	+= notificationDelta;
			
			if ( (notificationCounter >= notificationsPerSecond) && !this.hasMatchedChars() )
			{
				if ( Math.round( Math.random() ) == 1 )
				{
					dropLetter();
				}
				
				notificationCounter = 0;
			}
		}

		public function getType():int
		{
			return EnemyTypes.DROP_LETTER_WORD_ENEMY_TYPE;
		}
		
		private function dropLetter():void
		{		
			var bombDropped:Boolean = bombCreator.createBomb( this.getData().charAt(this.letterToDropIndex), this.getX() + (this.letterToDropIndex * (this.getWidth() / this.getData().length)), this.getY() + this.getHeight() );

			if ( bombDropped )
			{
				this.droppedLetterIndexes.push(this.letterToDropIndex); 
				droppedLetterCounter++;
				fireLetterDroppedEvent();
				//if we're not above the maximum, pick another letter to drop. If it's the same letter as before, just stop dropping letters
				if ( droppedLetterCounter < maxLettersToDrop )
				{
					var newLetterToDropIndex:int = this.chooseLetterIndexToDrop();
					
					if ( newLetterToDropIndex != -1 )
					{
						this.letterToDropIndex = newLetterToDropIndex;
						fireLetterToDropChosenEvent();
					}
					else
					{
						this.unregisterSpecialEnemyFromNotification();
					}
				}
				else
				{
					this.unregisterSpecialEnemyFromNotification();
				}
			}
		}

		private function chooseLetterIndexToDrop():int
		{
			if ( this.availableLettersToDrop.length > 0 )
			{
				var availableLetterIndex:int = Math.floor( Math.random() * this.availableLettersToDrop.length );
				var chosenLetterIndex:int = availableLettersToDrop[availableLetterIndex];
				
				this.availableLettersToDrop.splice( availableLetterIndex, 1 );
				
				return chosenLetterIndex;
			}
			else
			{
				return -1;
			}
		}
		
		private function chooseAvailableLettersToDrop():void
		{
			var firstLetter:String = this.getData().charAt( 0 );
			
			for ( var letterIndex:int = 1; letterIndex < this.getData().length; letterIndex++ )
			{
				var curLetter:String = this.getData().charAt( letterIndex );
				
				if ( curLetter != firstLetter )
					this.availableLettersToDrop.push( letterIndex );
			}
		}
		
		public override function addEnemyListener(enemyListener:IEnemyListener):void 
		{
			this.dropLetterWordListeners.push( enemyListener );
			
			super.addEnemyListener(enemyListener);
			fireLetterToDropChosenEventForListener(enemyListener as IDropLetterWordListener);
		}
		
		public override function die():void 
		{
			if ( registered ) 
			{
				this.unregisterSpecialEnemyFromNotification();
			}

			super.die();
		}
		
		public override function matchNextChar( nextChar:String ):int
		{
			var curCharIndex:int = this.getCharIndex();
			var matchResult:int = super.matchNextChar(nextChar);
			var missingLetterIndex:int = this.droppedLetterIndexes.indexOf(curCharIndex);
	
			if( missingLetterIndex != -1 )
				this.droppedLetterIndexes.splice( missingLetterIndex, 1 );
				
			if ( (matchResult != CharacterMatchResults.MATCH_FAILURE) && (missingLetterIndex != -1) )
			{
				this.fireRevealMatchedLetterEvent( curCharIndex );
			}
			
			return matchResult;
		}
		
		public function getNumLettersDropped():int
		{
			return this.droppedLetterCounter;
		}
		
		public function revealAllLetters():void
		{
			this.droppedLetterIndexes = new Array();
			this.revealed = true;
			this.unregisterSpecialEnemyFromNotification();
			this.fireRevealAllMissingLettersEvent();
		}		
		
		private function fireLetterToDropChosenEvent():void
		{
			if ( dropLetterWordListeners[0] != null )
			{
				dropLetterWordListeners[0].letterToDropChosen( this.letterToDropIndex );
			}
		}
		
		private function unregisterSpecialEnemyFromNotification():void
		{
			this.specialEnemyNotifier.unregisterSpecialEnemyFromNotification(this);
			this.registered = false;
		}
		
		private function fireLetterDroppedEvent():void
		{
			if ( dropLetterWordListeners[0] != null )
			{
				var newDimension:Dimension = dropLetterWordListeners[0].letterDropped( this.letterToDropIndex );
				
				if ( newDimension != null )
					this.updateDimensions( newDimension );
			}
		}
		
		private function fireLetterToDropChosenEventForListener(dropLetterWordListener:IDropLetterWordListener):void
		{
			dropLetterWordListener.letterToDropChosen( this.letterToDropIndex );
		}
		
		private function fireRevealAllMissingLettersEvent():void
		{
			if ( dropLetterWordListeners[0] != null )
			{
				var newDimension:Dimension = dropLetterWordListeners[0].revealAllHiddenLetters( this.getData() );

				if ( newDimension != null )
				{
					updateDimensions( newDimension );
				}	
			}
		}
		
		private function fireRevealMatchedLetterEvent( matchedLetterIndex:int ):void
		{
			if ( dropLetterWordListeners[0] != null )
			{
				dropLetterWordListeners[0].revealMatchedLetter( matchedLetterIndex, this.getData().charAt( matchedLetterIndex ));
			}
		}		
	}
	
}