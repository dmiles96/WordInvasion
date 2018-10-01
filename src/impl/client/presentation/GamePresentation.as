package impl.client.presentation 
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import iface.client.animation.IAnimationEngine;
	import iface.client.animation.IAnimationEngineListener;
	import iface.client.presentation.IGamePresentation;
	import iface.client.presentation.level.ILevelPresentation;
	import iface.client.presentation.level.ILevelPresentationFactory;
	import iface.client.presentation.level.ILevelPresentationListener;
	import iface.client.presentation.score.IScoreManagerPresentation;
	import iface.client.presentation.score.IScoreManagerPresentationListener;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.audio.ISoundMixer;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.service.video.IUpdateableCanvas;
	import iface.client.view.components.IDialog;
	import iface.client.view.components.IDialogFactory;
	import iface.client.view.components.IGamePauseDialog;
	import iface.client.view.components.ILevelStartDialog;
	import iface.common.domain.GameStates;
	import iface.common.domain.IGame;
	import iface.common.domain.IGameStateChangeListener;
	import iface.common.domain.level.ILevel;
	import impl.client.service.video.Canvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GamePresentation implements IScoreManagerPresentationListener, ILevelPresentationListener, IAnimationEngineListener, IGameStateChangeListener, IGamePresentation
	{
		private var sceneCanvas:IUpdateableCanvas = null;
		private var levelPresentationFactory:ILevelPresentationFactory = null;
		private var drawingSurface:IUpdateableCanvas = null;
		private var levelPresentation:ILevelPresentation = null;
		private var dialogFactory:IDialogFactory = null;
		private var playAreaWidth:int = 0;
		private var playAreaHeight:int = 0;
		private var levelWonDialog:IDialog = null;
		private var levelLostDialog:IDialog = null;
		private var gamePausedDialog:IGamePauseDialog = null;
		private var state:int = -1;
		private var dialogLocation:Point = null;
		private var dialogWidth:int = 0;
		private var dialogHeight:int = 0;
		private var levelNumberCanvas:ICanvas = null;
		private var levelNumberTextField:TextField = new TextField();
		private var animationEngine:IAnimationEngine = null;
		private var scoreManagerPresentation:IScoreManagerPresentation = null;
		private var standardTextFormat:TextFormat = null;
		private var gameOverSound:IGameSound = null;
		private var levelCompleteSound:IGameSound= null;
		private var gamePauseSound:IGameSound = null;
		private var soundMixer:ISoundMixer = null;
		private var levelStartDialog:ILevelStartDialog = null;
		
		public function GamePresentation(	canvasFactory:ICanvasFactory, game:IGame, animationEngine:IAnimationEngine, drawingSurface:IUpdateableCanvas, 
											levelPresentationFactory:ILevelPresentationFactory, scoreManagerPresentation:IScoreManagerPresentation, 
											playAreaWidth:int, playAreaHeight:int, dialogFactory:IDialogFactory, standardTextFormat:TextFormat, 
											gameOverSound:IGameSound, levelCompleteSound:IGameSound, gamePauseSound:IGameSound, soundMixer:ISoundMixer ) 
		{
			this.sceneCanvas = drawingSurface;
			this.levelPresentationFactory = levelPresentationFactory;
			this.drawingSurface = drawingSurface;
			this.playAreaWidth = playAreaWidth;
			this.playAreaHeight = playAreaHeight;
			this.dialogFactory = dialogFactory;
			this.animationEngine = animationEngine;
			this.scoreManagerPresentation = scoreManagerPresentation;
			this.standardTextFormat = standardTextFormat;
			this.gameOverSound = gameOverSound;
			this.levelCompleteSound = levelCompleteSound;
			this.gamePauseSound = gamePauseSound;
			this.soundMixer = soundMixer;
			
			this.standardTextFormat.size = 32;
			
			var scoreCanvas:ICanvas = scoreManagerPresentation.getCanvas();
			
			this.positionScoreCanvas(scoreCanvas);
			
			this.drawingSurface.addCanvas(scoreCanvas);		
			this.drawingSurface.addCanvas( this.createLevelNumberCanvas( 0, 0, canvasFactory ));

			this.dialogLocation = new Point( 20, (this.playAreaHeight / 2) - (this.playAreaHeight / 8) );
			this.dialogWidth = this.playAreaWidth - 40;
			this.dialogHeight = this.playAreaHeight / 4;
			
			this.levelNumberTextField.selectable = false;
			this.levelNumberTextField.embedFonts = true;
			this.levelNumberTextField.autoSize = TextFieldAutoSize.LEFT;
			this.levelNumberTextField.type = TextFieldType.DYNAMIC;
			
			this.soundMixer.decreaseVolume();
			this.soundMixer.decreaseVolume();
			this.soundMixer.decreaseVolume();
			
			animationEngine.addAnimationEngineListener(this);
			game.addGameStateChangeListener(this);
			scoreManagerPresentation.addScoreManagerPresentationListener(this);
		}
		
		public function gameStarted():void
		{
			this.state = GameStates.STARTED_GAME_STATE;
		}
		
		public function gamePaused():void
		{
			if ( this.gamePausedDialog == null )
				this.gamePausedDialog = dialogFactory.createGamePausedDialog( this.dialogLocation, this.dialogWidth, this.dialogHeight, this.getVolumePecentage(soundMixer.getVolume()));
				
			this.gamePausedDialog.show( this.drawingSurface );
			this.animationEngine.pause();			
			this.soundMixer.pauseAll();
			this.state = GameStates.PAUSED_GAME_STATE;

			this.markSceneDirty();
			this.gamePauseSound.play();
		}
		
		public function gameUnpaused():void
		{
			this.gamePausedDialog.close();
			this.animationEngine.unPause();
			this.soundMixer.playAll();
			this.state = GameStates.STARTED_GAME_STATE;
			
			this.markSceneDirty();
		}
		
		public function gamePausedInputCommand( command:String ):void
		{
			var newVolume:Number = 0;
			
			if ( command == "+" )
			{
				newVolume = this.soundMixer.increaseVolume();
			}
			else if( command == "-" )
			{	
				newVolume = this.soundMixer.decreaseVolume();
			}
			else
			{
				return;
			}
			
			this.gamePausedDialog.updateVolumeDisplay( this.getVolumePecentage(newVolume)  );
		}
		
		public function gameQuit():void
		{
			this.soundMixer.stopAll();
		}
		
		public function levelCreated(newLevel:ILevel):void
		{
			this.levelPresentation = levelPresentationFactory.createLevelPresentation( newLevel );
			
			this.drawingSurface.addCanvas( this.levelPresentation.getCanvas() );
			this.levelPresentation.start();
			
			this.markSceneDirty();
		}
		
		public function levelStarted(levelNumber:int):void
		{
			if ( this.state == GameStates.LEVEL_STARTING_GAME_STATE )
			{
				this.levelStartDialog.close();
			}
			
			this.levelNumberTextField.text = levelNumber.toString();
			this.levelNumberTextField.setTextFormat(this.standardTextFormat);
			this.state = GameStates.STARTED_GAME_STATE;
			
			this.markSceneDirty();
		}
		
		public function levelWon(rewarded:Boolean):void
		{
			this.state = GameStates.LEVEL_WON_GAME_STATE;
			
			if( this.levelWonDialog == null )
				this.levelWonDialog = dialogFactory.createLevelWonDialog( this.dialogLocation, this.dialogWidth, this.dialogHeight);
			
			System.gc();
			this.scoreManagerPresentation.clearBonusMessage();
			this.levelWonDialog.show( this.drawingSurface );
			
			this.markSceneDirty();
			this.levelCompleteSound.play();
		}
		
		public function levelLost():void
		{
			this.state = GameStates.LEVEL_LOST_GAME_STATE;
			
			if( this.levelLostDialog == null )
				this.levelLostDialog = dialogFactory.createLevelLostDialog( this.dialogLocation, this.dialogWidth, this.dialogHeight);
			
			System.gc();
			this.scoreManagerPresentation.clearBonusMessage();
			this.levelLostDialog.show( this.drawingSurface );
			
			this.markSceneDirty();
			this.gameOverSound.play();
		}
		
		public function nextLevelStartMessage(startMessage:String):void
		{
			var startDialogShowing:Boolean = true;
			
			if ( this.state == GameStates.LEVEL_WON_GAME_STATE )
			{
				this.levelWonDialog.close();
				startDialogShowing = false;
				this.state = GameStates.LEVEL_STARTING_GAME_STATE;
			}
			else if ( this.state == GameStates.STARTED_GAME_STATE )
			{
				startDialogShowing = false;
				this.state = GameStates.LEVEL_STARTING_GAME_STATE;
			}
			
			if ( this.levelStartDialog == null )
			{
				this.levelStartDialog = dialogFactory.createLevelStartDialog( this.dialogLocation, this.dialogWidth, this.dialogHeight);
			}
			
			if ( !startDialogShowing )
				this.levelStartDialog.show(this.drawingSurface);
			
			this.levelStartDialog.updateStartMessage(startMessage);	
			
		}
		
		public function levelUpdated():void
		{
			this.markSceneDirty();
		}

		public function scoreDisplayChanged(scoreCanvas:ICanvas):void
		{
			this.positionScoreCanvas(scoreCanvas);
			this.markSceneDirty();
		}
		
		public function frameCompleted( animationsOccured:Boolean ):void
		{
			if ( animationsOccured )
				this.markSceneDirty();
		}
		
		private function getVolumePecentage( volume:Number ):int
		{
			return volume * 100;
		}
		
		private function positionScoreCanvas(scoreCanvas:ICanvas):void
		{
			scoreCanvas.setX( (playAreaWidth / 2) - (scoreCanvas.getWidth() / 2) );
			scoreCanvas.setY(0);			
		}
		
		private function markSceneDirty():void
		{
			this.sceneCanvas.markDirty();
		}
		
		private function createLevelNumberCanvas( x:int, y:int, canvasFactory:ICanvasFactory ):ICanvas
		{
			var levelNumberSprite:Sprite = new Sprite();
			levelNumberTextField = new TextField();
			
			levelNumberSprite.addChild( levelNumberTextField );
			levelNumberSprite.x = x;
			levelNumberSprite.y = y;
			
			return canvasFactory.createCanvasFromSprite(levelNumberSprite);
		}
	}
	
}