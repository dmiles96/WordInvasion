package impl.client.configuration 
{
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;	
	import flash.utils.Dictionary;
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.audio.ISoundPlayer;
	import iface.common.domain.enemy.IEnemySizeComputer;
	import impl.client.presentation.enemy.EnemySizeComputer;
	import impl.common.configuration.ApplicationConfiguration;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ApplicationConfiguration extends impl.common.configuration.ApplicationConfiguration implements IApplicationConfiguration
	{
		private const animationFramesPerSecond:int = 30;
		private const keyboardPollsPerSecond:int = 30;
		private const scoreBonusMessage:String = "Power Up bonus!";
		private var ticksToShowScoreBonusMessage:int = 0;
		private const powerUpStartY:int = 0;
		private const powerUpWidth:int = 36;
		private const powerUpHeight:int = 36;
		private const powerUpPadding:int = 5;
		private var enemySizeComputer:IEnemySizeComputer = null;
		private const enemyStandardCharacterFormat:TextFormat = new TextFormat("Atari", null, 0xFFFFFF); 		
		private const typedCharacterFormat:TextFormat = new TextFormat("Atari", null, 0xFF0000, null); 
		private const readyToDropCharacterFormat:TextFormat = new TextFormat("Atari", null, 0x000000); 
		private const projectileWidth:int = 2;
		private const projectileHeight:int = 15;
		private const projectileSoundId:String = "projectile";
		private const explosionSoundId:String = "explosion";
		private const powerUpSlotEmptlySoundId:String = "powerupslotempty";
		private const powerUpUsedSoundId:String = "powerupused";
		private const collisionSoundId:String = "collision";
		private const bonusEnemySoundId:String = "bonusenemy";
		private const bombDropSoundId:String = "bombdrop";
		private const powerUpAppearsSoundId:String = "powerupappears";
		private const gameOverSoundId:String = "gameover";
		private const levelCompleteSoundId:String = "levelcomplete";
		private const pauseSoundId:String = "pause";
		private const powerUpExplodeSoundId:String = "powerupexplode";
		private const powerUpPauseSoundId:String = "poweruppause";
		private const powerUpRevealSoundId:String = "powerupreveal";
		private const powerUpCharacterFormat:TextFormat = new TextFormat("Atari", 32, 0xFFFFFF, null, null, null, null, null );
		private const maxScoreToDisplay:int = 999999;
		private const hiddenCharacterMarker:String = "_";
		private const leftDialogMargin:int = 20;
		private const highscoreFieldMargin:int = 10;
		private const highscoreFieldPadding:int = 10;
		private const gameTitleTextFormat:TextFormat = new TextFormat("Atari", 48, 0xFFFFFF, null, null, null, null, null );
		private const typoSoundId:String = "typo";
		
		private const soundDatabase:Dictionary = new Dictionary();
		
		public function ApplicationConfiguration() 
		{
			this.enemyStandardCharacterFormat.size = 16;
			this.typedCharacterFormat.size = 16;
			this.readyToDropCharacterFormat.size = 16;
			
			this.ticksToShowScoreBonusMessage = this.getGameUpdatesPerSecond() * 4;
			this.enemySizeComputer = new EnemySizeComputer(this. getEnemyStandardCharacterFormat());
		}
		
		public function getAnimationFramesPerSecond():int { return this.animationFramesPerSecond; }
		public function getKeyboardPollsPerSecond():int { return this.keyboardPollsPerSecond; }
		public function getScoreBonusMessage():String { return this.scoreBonusMessage; }
		public function getTicksToShowScoreBonusMessage():int { return this.ticksToShowScoreBonusMessage; }
		public function getPowerUpStartY():int { return this.powerUpStartY; }
		public function getPowerUpWidth():int { return this.powerUpWidth; }
		public function getPowerUpHeight():int { return this.powerUpHeight; }
		public function getPowerUpPadding():int { return this.powerUpPadding; }
		public function getEnemySizeComputer():IEnemySizeComputer { return this.enemySizeComputer; }
		public function getStandardCharacterFormat():TextFormat { return new TextFormat("Atari", null, 0xFFFFFF); }
		public function getEnemyStandardCharacterFormat():TextFormat { return enemyStandardCharacterFormat; }
		public function getEnemyTypedCharacterFormat():TextFormat { return typedCharacterFormat; }
		public function getEnemyReadyToDropCharacterFormat():TextFormat { return readyToDropCharacterFormat; }
		public function getProjectileWidth():int { return this.projectileWidth; }
		public function getProjectileHeight():int { return this.projectileHeight; }
		public function getProjectileSoundId():String { return this.projectileSoundId; }
		public function getProjectileSound():IGameSound { return this.soundDatabase[this.projectileSoundId]; }
		public function getExplosionSoundId():String { return this.explosionSoundId; }
		public function getExplosionSound():IGameSound { return this.soundDatabase[this.explosionSoundId]; }
		public function getPowerUpSlotEmptySoundId():String { return powerUpSlotEmptlySoundId; }
		public function getPowerUpSlotEmptySound():IGameSound { return this.soundDatabase[this.powerUpSlotEmptlySoundId];; }
		public function getPowerUpUsedSoundId():String { return powerUpUsedSoundId; }
		public function getPowerUpUsedSound():IGameSound { return this.soundDatabase[this.powerUpUsedSoundId];; }
		public function getCollisionSoundId():String { return this.collisionSoundId; }
		public function getCollisionSound():IGameSound { return this.soundDatabase[this.collisionSoundId]; }		
		public function getBonusEnemySoundId():String { return this.bonusEnemySoundId; }
		public function getBonusEnemySound():IGameSound { return this.soundDatabase[this.bonusEnemySoundId]; }
		public function getBombDropSoundId():String { return this.bombDropSoundId; }
		public function getBombDropSound():IGameSound { return this.soundDatabase[this.bombDropSoundId]; }
		public function getPowerUpAppearsSoundId():String { return this.powerUpAppearsSoundId; }
		public function getPowerUpAppearsSound():IGameSound { return this.soundDatabase[this.powerUpAppearsSoundId]; }
		public function getGameOverSoundId():String { return this.gameOverSoundId; }
		public function getGameOverSound():IGameSound { return this.soundDatabase[this.gameOverSoundId]; }
		public function getLevelCompleteSoundId():String { return this.levelCompleteSoundId; }
		public function getLevelCompleteSound():IGameSound { return this.soundDatabase[this.levelCompleteSoundId]; }
		public function getPauseSoundId():String { return this.pauseSoundId; }
		public function getPauseSound():IGameSound { return this.soundDatabase[this.pauseSoundId]; }
		public function getPowerUpExplodeSoundId():String { return this.powerUpExplodeSoundId; }
		public function getPowerUpExplodeSound():IGameSound { return this.soundDatabase[this.powerUpExplodeSoundId]; }
		public function getPowerUpPauseSoundId():String { return this.powerUpPauseSoundId; }
		public function getPowerUpPauseSound():IGameSound { return this.soundDatabase[this.powerUpPauseSoundId]; }
		public function getPowerUpRevealSoundId():String { return this.powerUpRevealSoundId; }
		public function getPowerUpRevealSound():IGameSound { return this.soundDatabase[this.powerUpRevealSoundId]; }
		public function getPowerUpCharacterFormat():TextFormat { return this.powerUpCharacterFormat; }
		public function getMaxScoreToDisplay():int { return this.maxScoreToDisplay; }
		public function getHiddenCharacterMarker():String { return this.hiddenCharacterMarker; }
		public function getLeftDialogMargin():int { return this.leftDialogMargin; }
		public function getHighscoreFieldMargin():int { return this.highscoreFieldMargin; }
		public function getHighscoreFieldPadding():int { return this.highscoreFieldPadding; }
		public function getGameTitleTextFormat():TextFormat { return this.gameTitleTextFormat; }
		public function getTypoSoundId():String { return this.typoSoundId; }
		public function getTypoSound():IGameSound { return this.soundDatabase[this.typoSoundId]; }
		
		public function addSoundData( soundId:String, soundData:IGameSound ):void { this.soundDatabase[soundId] = soundData }
	}
	
}