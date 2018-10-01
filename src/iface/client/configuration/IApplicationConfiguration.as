package iface.client.configuration
{
	
	import flash.text.TextFormat;
	import iface.client.service.audio.IGameSound;
	import iface.common.configuration.IApplicationConfiguration;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IApplicationConfiguration extends iface.common.configuration.IApplicationConfiguration
	{
		function getAnimationFramesPerSecond():int;
		function getKeyboardPollsPerSecond():int;
		function getScoreBonusMessage():String;
		function getTicksToShowScoreBonusMessage():int;
		function getPowerUpStartY():int;
		function getPowerUpWidth():int;
		function getPowerUpHeight():int;
		function getPowerUpPadding():int;
		function getStandardCharacterFormat():TextFormat;
		function getEnemyStandardCharacterFormat():TextFormat;
		function getEnemyTypedCharacterFormat():TextFormat;
		function getEnemyReadyToDropCharacterFormat():TextFormat;
		function getProjectileWidth():int;
		function getProjectileHeight():int;
		function getProjectileSoundId():String;
		function getProjectileSound():IGameSound;
		function getExplosionSoundId():String;
		function getExplosionSound():IGameSound;
		function getPowerUpSlotEmptySoundId():String;
		function getPowerUpSlotEmptySound():IGameSound;
		function getPowerUpUsedSoundId():String;
		function getPowerUpUsedSound():IGameSound;
		function getCollisionSoundId():String;
		function getCollisionSound():IGameSound;
		function getBonusEnemySoundId():String;
		function getBonusEnemySound():IGameSound;
		function getBombDropSoundId():String;
		function getBombDropSound():IGameSound;
		function getPowerUpAppearsSoundId():String;
		function getPowerUpAppearsSound():IGameSound;
		function getGameOverSoundId():String;
		function getGameOverSound():IGameSound;
		function getLevelCompleteSoundId():String;
		function getLevelCompleteSound():IGameSound;
		function getPauseSoundId():String;
		function getPauseSound():IGameSound;
		function getPowerUpExplodeSoundId():String;
		function getPowerUpExplodeSound():IGameSound;
		function getPowerUpPauseSoundId():String;
		function getPowerUpPauseSound():IGameSound;
		function getPowerUpRevealSoundId():String;
		function getPowerUpRevealSound():IGameSound;
		function getPowerUpCharacterFormat():TextFormat;
		function getMaxScoreToDisplay():int;
		function getHiddenCharacterMarker():String;
		function getLeftDialogMargin():int;
		function getHighscoreFieldMargin():int;
		function getHighscoreFieldPadding():int;
		function getGameTitleTextFormat():TextFormat;
		function getTypoSoundId():String;
		function getTypoSound():IGameSound;	
		
		function addSoundData( soundId:String, soundData:IGameSound ):void;
	}
	
}