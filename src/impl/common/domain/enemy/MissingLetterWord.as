package impl.common.domain.enemy 
{
	import iface.common.domain.Dimension;
	import iface.common.domain.enemy.CharacterMatchResults;
	import iface.common.domain.enemy.EnemyTypes;
	import iface.common.domain.enemy.IEnemyListener;
	import iface.common.domain.enemy.IMissingLetterWord;
	import iface.common.domain.enemy.IMissingLetterWordListener;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.ICollisionDetector;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MissingLetterWord extends FallingEnemy implements IMissingLetterWord
	{
		private var missingLetterIndexes:Array = new Array();
		private var missingLetterWordListeners:Array = new Array();
		
		public function MissingLetterWord(data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int, ticksToExplode:int) 
		{
			super(data, positioner, collisionDetector, velocityComputer, width, height, ticksToExplode, velocityComputer.computeFallingEnemyVelocity(height));
			
			var maxMissingLetters:int = Math.ceil( data.length / 3 );
			var missingLetterCounter:int = 0
			
			for ( var charIndex:int = 1; (charIndex < data.length) && (missingLetterCounter < maxMissingLetters); charIndex++ )
			{
				if ( Math.round( Math.random() ) == 1 )
				{
					missingLetterIndexes.push(charIndex);
					missingLetterCounter++;
					charIndex++; //make sure that no two letters next to each other are missing
				}
			}

			//if we didn't pick any, force the pick of one
			if ( this.missingLetterIndexes.length == 0 )
			{
				this.missingLetterIndexes.push( Math.floor( Math.random() * (data.length - 1) ) + 1 );
			}
		}
		
		public function revealAllLetters():void
		{
			missingLetterIndexes = new Array();
			this.fireRevealAllMissingLettersEvent();
		}
		
		public function getType():int
		{
			return EnemyTypes.MISSING_LETTER_WORD_ENEMY_TYPE;
		}
		
		public function getNumMissingLetters():int
		{
			return this.missingLetterIndexes.length;
		}
		
		public override function addEnemyListener(enemyListener:IEnemyListener):void 
		{
			super.addEnemyListener(enemyListener);
			
			this.missingLetterWordListeners.push(enemyListener);
			fireMissingLetterChosenEventForListener(enemyListener as IMissingLetterWordListener);
		}
		
		public override function matchNextChar( nextChar:String ):int
		{
			var curCharIndex:int = this.getCharIndex();
			var matchResult:int = super.matchNextChar(nextChar);
			var missingLetterIndex:int = missingLetterIndexes.indexOf(curCharIndex);
	
			if( (matchResult != CharacterMatchResults.MATCH_FAILURE) && (missingLetterIndex != -1) )
				this.missingLetterIndexes.splice( missingLetterIndex, 1 );
			
			if ( (matchResult != CharacterMatchResults.MATCH_FAILURE) && (missingLetterIndex != -1) )
			{
				this.fireRevealMatchedLetterEvent( curCharIndex );
			}
			
			return matchResult;
		}
		
		private function fireMissingLetterChosenEventForListener(missingLetterWordListener:IMissingLetterWordListener):void
		{
			var newDimension:Dimension = missingLetterWordListener.missingLettersChosen( this.missingLetterIndexes );
			
			if ( newDimension != null )
			{
				updateDimensions( newDimension );
			}
		}
		
		private function fireRevealAllMissingLettersEvent():void
		{
			if ( missingLetterWordListeners[0] != null )
			{
				var newDimension:Dimension = missingLetterWordListeners[0].revealAllHiddenLetters( this.getData() );
				
				if ( newDimension != null )
				{
					updateDimensions( newDimension );
				}				
			}
		}
		
		private function fireRevealMatchedLetterEvent( matchedLetterIndex:int ):void
		{
			if ( missingLetterWordListeners[0] != null )
			{
				missingLetterWordListeners[0].revealMatchedLetter( matchedLetterIndex, this.getData().charAt( matchedLetterIndex ));
			}
		}
	}
	
}