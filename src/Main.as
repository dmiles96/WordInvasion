package 
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import iface.client.service.audio.ISoundFactory;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.workflow.IStartGameWorkflow;
	import impl.client.scope.ApplicationScope;
	import impl.client.scope.ApplicationScopeFactory;
	import impl.client.service.audio.SoundFactory;
	import impl.client.service.video.CanvasFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends Sprite 
	{
		private var applicationScope:ApplicationScope = null;

		[Embed(source="..\\res\\ATARCC__.TTF", fontName="Atari", mimeType="application/x-font-truetype", unicodeRange="U+0021-U+007B")]
		public static var GameFont:Class;
		
		[Embed(source="..\\res\\bombdrop.mp3", mimeType="audio/mpeg")]
		public static var BombDropSound:Class;

		[Embed(source="..\\res\\bonusenemy.mp3", mimeType="audio/mpeg")]
		public static var BonusEnemySound:Class;
		
		[Embed(source="..\\res\\collision.mp3", mimeType="audio/mpeg")]
		public static var CollisionSound:Class;
		
		[Embed(source="..\\res\\projectile.mp3", mimeType="audio/mpeg")]
		public static var ProjectileSound:Class;

		[Embed(source="..\\res\\explosion.mp3", mimeType="audio/mpeg")]
		public static var ExplosionSound:Class;

		[Embed(source="..\\res\\gameover.mp3", mimeType="audio/mpeg")]
		public static var GameOverSound:Class;
		
		[Embed(source="..\\res\\levelcomplete.mp3", mimeType="audio/mpeg")]
		public static var LevelCompleteSound:Class;
		
		[Embed(source="..\\res\\pause.mp3", mimeType="audio/mpeg")]
		public static var PauseSound:Class;
		
		[Embed(source="..\\res\\powerupappears.mp3", mimeType="audio/mpeg")]
		public static var PowerUpAppears:Class;

		[Embed(source="..\\res\\powerupexplode.mp3", mimeType="audio/mpeg")]
		public static var PowerUpExplode:Class;
		
		[Embed(source="..\\res\\poweruppause.mp3", mimeType="audio/mpeg")]
		public static var PowerUpPause:Class;

		[Embed(source="..\\res\\powerupreveal.mp3", mimeType="audio/mpeg")]
		public static var PowerUpReveal:Class;
		
		[Embed(source="..\\res\\powerupslotempty.mp3", mimeType="audio/mpeg")]
		public static var PowerUpSlotEmpty:Class;
		
		[Embed(source="..\\res\\typo.mp3", mimeType="audio/mpeg")]
		public static var Typo:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			this.startGame();
		}
	
		private function startGame():void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.stageFocusRect = false;
			
			var soundFactory:ISoundFactory = new SoundFactory(new SoundTransform());
			var canvasFactory:ICanvasFactory = new CanvasFactory(this);
			var applicationScopeFactory:ApplicationScopeFactory = new ApplicationScopeFactory(canvasFactory, soundFactory);
		
			applicationScope = applicationScopeFactory.createApplicationScope();
			applicationScope.getWorfklowEngine().executeStartGameWorkflow();
						
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getBombDropSoundId(), soundFactory.createGameSoundFromSound(new BombDropSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getBonusEnemySoundId(), soundFactory.createGameSoundFromSound(new BonusEnemySound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getCollisionSoundId(), soundFactory.createGameSoundFromSound(new CollisionSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getProjectileSoundId(), soundFactory.createGameSoundFromSound(new ProjectileSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getExplosionSoundId(), soundFactory.createGameSoundFromSound(new ExplosionSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getGameOverSoundId(), soundFactory.createGameSoundFromSound(new GameOverSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getLevelCompleteSoundId(), soundFactory.createGameSoundFromSound(new LevelCompleteSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getPauseSoundId(), soundFactory.createGameSoundFromSound(new PauseSound as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getPowerUpAppearsSoundId(), soundFactory.createGameSoundFromSound(new PowerUpAppears as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getPowerUpExplodeSoundId(), soundFactory.createGameSoundFromSound(new PowerUpExplode as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getPowerUpPauseSoundId(), soundFactory.createGameSoundFromSound(new PowerUpPause as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getPowerUpRevealSoundId(), soundFactory.createGameSoundFromSound(new PowerUpReveal as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getPowerUpSlotEmptySoundId(), soundFactory.createGameSoundFromSound(new PowerUpSlotEmpty as Sound ));
			applicationScope.getApplicationConfiguration().addSoundData( applicationScope.getApplicationConfiguration().getTypoSoundId(), soundFactory.createGameSoundFromSound(new Typo as Sound ));			
		}
	}	
}