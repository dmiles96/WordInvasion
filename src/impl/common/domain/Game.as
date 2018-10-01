package impl.common.domain
{
	import iface.common.domain.CommandTypes;
	import iface.common.domain.GameStates;
	import iface.common.domain.IGame;
	import iface.common.domain.IGameStateChangeListener;
	import iface.common.domain.level.ILevel;
	import iface.common.domain.level.ILevelCompleteListener;
	import iface.common.domain.level.ILevelFactory;
	import iface.common.domain.reward.IRewardExecutor;
	import iface.common.domain.reward.IRewardManager;
	import iface.common.domain.reward.IRewardManagerFactory;
	import iface.common.domain.score.IScoreManager;
	import iface.common.domain.score.IScoreManagerFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Game implements IRewardExecutor, ILevelCompleteListener, IGame
	{
		private var gameStateChangeListeners:Array = new Array();
		private var gameTicksPerSecond:int = 0;
		private var levelFactory:ILevelFactory = null;
		private var currentLevel:ILevel = null;
		private var scoreManager:IScoreManager = null;
		private var paused:Boolean = false;
		private var state:int = -1;
		private var levelNum:int = 1;
		private var rewardManager:IRewardManager = null;
		private var curStartMessages:Array = null;
		private var curStartMessageIndex:int = 0;
		
		public function Game( gameTicksPerSecond:int, levelFactory:ILevelFactory, scoreManagerFactory:IScoreManagerFactory, rewardManagerFactory:IRewardManagerFactory ) 
		{
			this.gameTicksPerSecond = gameTicksPerSecond;
			this.levelFactory = levelFactory;
			this.rewardManager = rewardManagerFactory.createRewardManager(this);
			this.scoreManager = scoreManagerFactory.createScoreManager(this.rewardManager);
		}
		
		public function getScoreManager():IScoreManager
		{
			return this.scoreManager;
		}
		
		public function addGameStateChangeListener(gameStateChangeListener: IGameStateChangeListener):void
		{
			gameStateChangeListeners.push(gameStateChangeListener);
		}
		
		public function start():void
		{
			this.currentLevel = levelFactory.createLevel(this.scoreManager, this.levelNum);
			this.currentLevel.addLevelCompleteListener( this );			
			
			this.fireLevelCreatedEvent(currentLevel);
			this.fireStartEvent();
			this.showLevelMessages();
		}
		
		public function tick(tickDelta:int):void
		{
			if(state == GameStates.STARTED_GAME_STATE)
				this.currentLevel.tick(tickDelta);
		}
		
		public function inputAlphaNumeric( typedChar:String ):void
		{
			if ( this.state == GameStates.STARTED_GAME_STATE )
			{
				this.currentLevel.inputAlphaNumeric( typedChar );
			}
			else if ( this.state == GameStates.LEVEL_WON_GAME_STATE )
			{
				if ( typedChar == " " )
				{
					gotoNextLevel();
				}
			}
			else if ( this.state == GameStates.PAUSED_GAME_STATE )
			{
				if ( (typedChar == "Q") || (typedChar == "q" ) )
				{
					this.state = GameStates.ENDED_GAME_STATE;
					this.fireQuitEvent();
				}
				else
				{
					this.firePausedInputCommandEvent(typedChar);
				}
			}
			else if ( this.state == GameStates.LEVEL_LOST_GAME_STATE )
			{
				if ( typedChar == " " )
				{
					this.state = GameStates.ENDED_GAME_STATE;
				}				
			}
			else if ( this.state == GameStates.LEVEL_STARTING_GAME_STATE )
			{
				if ( typedChar == " " )
				{
					if ( this.curStartMessageIndex < this.curStartMessages.length )
					{
						this.fireNextLevelMessageEvent(this.curStartMessages[this.curStartMessageIndex]);
						this.curStartMessageIndex++;
					}
					else
					{
						this.startNextLevel();
					}
					
				}				
			}		
		}
		
		public function inputCommand( command:int ):void
		{
			if ( this.state == GameStates.STARTED_GAME_STATE )
			{
				if ( command == CommandTypes.PAUSE_COMMAND )
				{
					this.handlePauseCommand();
				}			
				else
				{
					this.currentLevel.inputCommand( command );
				}
			}
			else if ( this.state == GameStates.PAUSED_GAME_STATE )
			{
				if ( command == CommandTypes.PAUSE_COMMAND )
				{
					this.handlePauseCommand();
				}				
			}
		}

		public function levelWon():void
		{
			this.state = GameStates.LEVEL_WON_GAME_STATE;
			
			if ( this.rewardManager.isLevelRewarded( this.levelNum ))
			{
				this.rewardManager.rewardLevel(this.levelNum);
				this.fireLevelWonEvent(true);
			}
			else
			{
				this.fireLevelWonEvent(false);
			}
		}
		
		public function levelLost():void
		{
			this.state = GameStates.LEVEL_LOST_GAME_STATE;
			
			this.fireLevelLostEvent();
		}
		
		public function repairCity():void
		{
			if( this.currentLevel != null )
				this.currentLevel.repairCity();
		}
		
		public function addRandomPowerup():Boolean
		{
			if ( this.currentLevel != null )
			{
				return this.currentLevel.addRandomPowerUp();
			}
			
			return false;
		}
		
		public function isEnded():Boolean
		{
			return this.state == GameStates.ENDED_GAME_STATE;
		}

		private function handlePauseCommand():void
		{
			if ( this.state == GameStates.PAUSED_GAME_STATE )
			{
				this.state = GameStates.STARTED_GAME_STATE;
				this.fireUnpausedEvent();
			}
			else
			{
				this.state = GameStates.PAUSED_GAME_STATE;
				this.firePausedEvent();
			}
		}
		
		private function showLevelMessages():void
		{
			this.curStartMessages = this.currentLevel.getStartMessages();
			this.curStartMessageIndex = 0;
			this.state = GameStates.LEVEL_STARTING_GAME_STATE;
			
			this.fireNextLevelMessageEvent(this.curStartMessages[this.curStartMessageIndex]);
			this.curStartMessageIndex++;
		}
		
		private function gotoNextLevel():void
		{
			this.levelNum++;
			this.currentLevel.changeAttributes(this.levelFactory.getLevelAttributes(levelNum));
			
			this.showLevelMessages();
		}
		
		private function startNextLevel():void
		{
			this.fireLevelStartedEvent(this.levelNum);
			this.state = GameStates.STARTED_GAME_STATE;
		}
		
		private function fireStartEvent():void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.gameStarted();
			}
		}

		private function fireLevelCreatedEvent( newLevel:ILevel ):void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.levelCreated(newLevel);
			}
		}
		
		private function fireLevelStartedEvent(levelNumber:int):void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.levelStarted(levelNumber);
			}
		}
		
		private function fireLevelWonEvent( rewarded:Boolean ):void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.levelWon( rewarded );
			}			
		}
		
		private function fireLevelLostEvent():void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.levelLost();
			}			
		}
		
		private function firePausedEvent():void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.gamePaused();
			}				
		}
		
		private function fireUnpausedEvent():void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.gameUnpaused();
			}				
		}
		
		private function firePausedInputCommandEvent( command:String ):void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.gamePausedInputCommand(command);
			}				
		}
		
		private function fireQuitEvent():void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.gameQuit();
			}				
		}
		
		private function fireNextLevelMessageEvent( startMessage:String ):void
		{
			for each( var gameStateChangeListener:IGameStateChangeListener in this.gameStateChangeListeners )
			{
				gameStateChangeListener.nextLevelStartMessage(startMessage);
			}			
		}
	}
	
}