package impl.common.domain.score 
{
	import iface.common.domain.enemy.EnemyTypes;
	import iface.common.domain.enemy.IDropLetterWord;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IMissingLetterWord;
	import iface.common.domain.reward.IRewardManager;
	import iface.common.domain.score.IScoreListener;
	import iface.common.domain.score.IScoreManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ScoreManager implements IScoreManager
	{
		private var score:int = 0;
		private var nonExsistantLetterAmount:int = 0;
		private var typoAmount:int = 0;
		private var perCharacterAmount:int = 0;
		private var bombAmount:int = 0;
		private var perBonusWordCharacterFactor:int = 0;
		private var perMissingCharacterBonusFactor:int = 0;
		private var perCharacterBonusAmountForNoUndroppedCharacters:int = 0;
		private var scoreListeners:Array = new Array();
		private var rewardManager:IRewardManager = null;
		
		public function ScoreManager( 	nonExsistantLetterAmount:int, typoAmount:int, perCharacterAmount:int, bombAmount:int, 
										perBonusWordCharacterFactor:int, perMissingCharacterBonusFactor:int, perCharacterBonusAmountForNoUndroppedCharacters:int, rewardManager:IRewardManager) 
		{
			this.nonExsistantLetterAmount = nonExsistantLetterAmount;
			this.typoAmount = typoAmount;
			this.perCharacterAmount = perCharacterAmount;
			this.bombAmount = bombAmount;
			this.perBonusWordCharacterFactor = perBonusWordCharacterFactor;
			this.perMissingCharacterBonusFactor = perMissingCharacterBonusFactor;
			this.perCharacterBonusAmountForNoUndroppedCharacters = perCharacterBonusAmountForNoUndroppedCharacters;
			this.rewardManager = rewardManager;
		}
		
		public function getScore():int
		{
			return this.score;
		}
		
		public function scoreNonExsistantLetter():void
		{
			this.score -= this.nonExsistantLetterAmount;

			if ( this.score < 0)
				this.score = 0;
				
			fireScoreChangedEvent(this.score);
		}
		
		public function scoreTypo():void
		{
			this.score -= this.typoAmount;

			if ( this.score < 0)
				this.score = 0;

			fireScoreChangedEvent(this.score);
		}
		
		public function scoreEnemyDeath( enemy:IEnemy ):void
		{
			if ( enemy.getType() == EnemyTypes.BOMB_ENEMY_TYPE )
			{
				this.score += this.bombAmount;
			}
			else if ( enemy.getType() == EnemyTypes.BONUS_WORD_ENEMY_TYPE )
			{
				this.score += enemy.getNumChars() * perBonusWordCharacterFactor;
			}
			else if ( enemy.getType() == EnemyTypes.DROP_LETTER_WORD_ENEMY_TYPE )
			{
				var dropLetterWord:IDropLetterWord = enemy as IDropLetterWord;
				
				if ( dropLetterWord.getNumLettersDropped() > 0 )
				{
					this.score += (dropLetterWord.getNumChars() - dropLetterWord.getNumLettersDropped()) * this.perCharacterAmount;
				}
				else
				{
					this.score += dropLetterWord.getNumChars() * ( this.perCharacterAmount + this.perCharacterBonusAmountForNoUndroppedCharacters );
				}				
			}
			else if ( enemy.getType() == EnemyTypes.MISSING_LETTER_WORD_ENEMY_TYPE )
			{
				var missingLetterWord:IMissingLetterWord = enemy as IMissingLetterWord;
				
				//add extra points for getting the missing letters
				this.score += missingLetterWord.getNumMissingLetters() * this.perCharacterAmount * this.perMissingCharacterBonusFactor;
				//add normal amount of points for the rest of the letters
				this.score += (missingLetterWord.getNumChars() - missingLetterWord.getNumMissingLetters()) * this.perCharacterAmount;
			}
			else if ( enemy.getType() == EnemyTypes.NORMAL_WORD_ENEMY_TYPE )
			{
				this.score += enemy.getNumChars() * this.perCharacterAmount;
			}
			
			this.rewardScore();
			fireScoreChangedEvent(this.score);
		}
		
		private function rewardScore():void
		{
			if ( this.rewardManager.isScoreRewarded( this.score ))
			{
				this.rewardManager.rewardScore( this.score );
				this.rewardManager.generateNextScoreReward();
				this.fireScoreRewardedEvent();
			}
		}
		
		public function addScoreListener( scoreListener:IScoreListener ):void
		{
			this.scoreListeners.push( scoreListener );
		}
		
		public function fireScoreChangedEvent( newScore:int ):void
		{
			if ( scoreListeners[0] != null )
				scoreListeners[0].scoreChanged( newScore );
		}
		
		public function fireScoreRewardedEvent():void
		{
			if ( scoreListeners[0] != null )
				scoreListeners[0].scoreRewarded();			
		}
	}
	
}