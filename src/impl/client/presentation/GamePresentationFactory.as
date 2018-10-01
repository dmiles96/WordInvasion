package impl.client.presentation 
{
	import iface.client.animation.IAnimationEngine;
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.presentation.city.ICityPresentation;
	import iface.client.presentation.enemy.IEnemyPresentation;
	import iface.client.presentation.enemy.IEnemyPresentationFactory;
	import iface.client.presentation.highscore.IHighscorePresentation;
	import iface.client.presentation.highscore.IHighscorePresentationFactory;
	import iface.client.presentation.highscore.IHighscorePresentationManager;
	import iface.client.presentation.highscore.IHighscorePresentationManagerFactory;
	import iface.client.presentation.IGamePresentationFactory;
	import iface.client.presentation.projectile.IProjectilePresentation;
	import iface.client.presentation.level.ILevelPresentation;
	import iface.client.presentation.level.ILevelPresentationFactory;
	import iface.client.presentation.powerup.IPowerUpPresentationManager;
	import iface.client.presentation.powerup.IPowerUpPresentationManagerFactory;
	import iface.client.presentation.projectile.IProjectilePresentationFactory;
	import iface.client.presentation.score.IScoreManagerPresentation;
	import iface.client.presentation.score.IScorePresentation;
	import iface.client.presentation.score.IScorePresentationFactory;
	import iface.client.service.audio.ISoundFactory;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.service.video.IUpdateableCanvas;
	import iface.client.view.components.IDialogFactory;
	import iface.common.domain.city.ICity;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.highscore.IHighscore;
	import iface.common.domain.IGame;
	import iface.client.presentation.IGamePresentation;
	import iface.common.domain.level.ILevel;
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.score.IScoreManager;
	import impl.client.presentation.city.CityPresentation;
	import impl.client.presentation.enemy.EnemyPresentation;
	import impl.client.presentation.highscore.HighscorePresentation;
	import impl.client.presentation.highscore.HighscorePresentationManager;
	import impl.client.presentation.level.LevelPresentation;
	import impl.client.presentation.powerup.PowerUpPresentationManager;
	import impl.client.presentation.projectile.ProjectilePresentation;
	import impl.client.presentation.score.ScoreManagerPresentation;
	import impl.client.presentation.score.ScorePresentation;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GamePresentationFactory implements IHighscorePresentationFactory, IHighscorePresentationManagerFactory, IScorePresentationFactory, IProjectilePresentationFactory, IPowerUpPresentationManagerFactory, IEnemyPresentationFactory, ILevelPresentationFactory, IGamePresentationFactory
	{
		private var appConfig:IApplicationConfiguration = null;
		private var animationEngine:IAnimationEngine = null;
		private var canvasFactory:ICanvasFactory = null;
		private var dialogFactory:IDialogFactory = null;
		private var soundFactory:ISoundFactory = null;
		
		public function GamePresentationFactory(appConfig:IApplicationConfiguration, animationEngine:IAnimationEngine,
												canvasFactory:ICanvasFactory, dialogFactory:IDialogFactory,
												soundFactory:ISoundFactory) 
		{
			this.appConfig = appConfig;
			this.animationEngine = animationEngine;
			this.canvasFactory = canvasFactory;
			this.dialogFactory = dialogFactory;
			this.soundFactory = soundFactory;
		}

		public function createGamePresentation( game:IGame, drawingSurface:IUpdateableCanvas ):IGamePresentation
		{
			return new GamePresentation(this.canvasFactory, game, this.animationEngine, drawingSurface, this, this.createScoreManagerPresentation( game.getScoreManager() ), appConfig.getPlayAreaWidth(), appConfig.getPlayAreaHeight(), this.dialogFactory, appConfig.getStandardCharacterFormat(), this.appConfig.getGameOverSound(), this.appConfig.getLevelCompleteSound(), this.appConfig.getPauseSound(), this.soundFactory.getSoundMixer() );
		}
		
		public function createLevelPresentation( level:ILevel ):ILevelPresentation
		{
			return new LevelPresentation( this.animationEngine, this, level, canvasFactory, this.createCityPresentation( level.getCity() ), appConfig.getCityYOffset(), level.getPowerUpManager(), this, this.appConfig.getTypoSound() );
		}
		
		public function createEnemyPresentation( enemy:IEnemy ):IEnemyPresentation
		{
			return new EnemyPresentation( 	this.canvasFactory, enemy, 
											appConfig.getEnemyStandardCharacterFormat(), appConfig.getEnemyTypedCharacterFormat(), appConfig.getEnemyReadyToDropCharacterFormat(), 
											this.animationEngine, 
											this.appConfig.getExplosionSound(), this.appConfig.getBombDropSound(), this.appConfig.getBonusEnemySound(), 
											this.appConfig.getCollisionSound(), this.appConfig.getHiddenCharacterMarker() );
		}
		
		public function createPowerUpPresentationManager( powerUpManager:IPowerUpManager, drawingSurface:ICanvas ):IPowerUpPresentationManager
		{
			return new PowerUpPresentationManager(	canvasFactory, powerUpManager, appConfig.getMaxNumPowerUps(), drawingSurface, 
													appConfig.getPlayAreaWidth(), appConfig.getPowerUpStartY(), appConfig.getPowerUpWidth(), appConfig.getPowerUpHeight(), 
													appConfig.getPowerUpPadding(), this.appConfig.getPowerUpAppearsSound(), this.appConfig.getPowerUpSlotEmptySound(), this.appConfig.getPowerUpExplodeSound(), this.appConfig.getPowerUpPauseSound(), this.appConfig.getPowerUpRevealSound(), this.appConfig.getPowerUpCharacterFormat() );
		}
		
		public function createProjectilePresentation( projectile:IProjectile ):IProjectilePresentation
		{
			return new ProjectilePresentation( this.canvasFactory, projectile, appConfig.getProjectileWidth(), appConfig.getProjectileHeight() );
		}
		
		public function createScorePresentation(score:int):IScorePresentation
		{
			return new ScorePresentation(score, this.appConfig.getMaxScoreToDisplay());
		}
		
		public function createHighscorePresentationManager( highscores:Array ):IHighscorePresentationManager
		{
			return new HighscorePresentationManager(highscores, this);
		}
		
		public function createHighscorePresentation( highscore:IHighscore ):IHighscorePresentation
		{
			return new HighscorePresentation( highscore.getName(), highscore.getScore(), this );
		}
		
		private function createCityPresentation( city:ICity ):ICityPresentation
		{
			return new CityPresentation( city, appConfig.getCityYOffset(), this, this.appConfig.getProjectileSound() );
		}
		
		private function createScoreManagerPresentation( scoreManager:IScoreManager ):IScoreManagerPresentation
		{
			return new ScoreManagerPresentation( this.animationEngine, this.canvasFactory, scoreManager, appConfig.getScoreBonusMessage(), appConfig.getTicksToShowScoreBonusMessage(), appConfig.getStandardCharacterFormat(), this);
		}
	}
	
}