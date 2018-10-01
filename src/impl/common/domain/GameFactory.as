package impl.common.domain 
{
	import iface.client.animation.IAnimationEngine;
	import iface.common.configuration.IApplicationConfiguration;
	import iface.common.domain.city.ICity;
	import iface.common.domain.dictionary.IDictionary;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyFactory;
	import iface.common.domain.enemy.IWord;
	import iface.common.domain.highscore.IHighscore;
	import iface.common.domain.highscore.IHighscoreFactory;
	import iface.common.domain.highscore.IHighscoreManager;
	import iface.common.domain.ICollisionDetector;
	import iface.common.domain.IGame;
	import iface.common.domain.IGameFactory;
	import iface.common.domain.level.ILevelFactory;
	import iface.common.domain.powerup.IPowerUpCommandExecutor;
	import iface.common.domain.powerup.IPowerUpManager;
	import iface.common.domain.powerup.IPowerUpManagerFactory;
	import iface.common.domain.powerup.ISpecialPowerUpNotifier;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.projectile.IProjectileFactory;
	import iface.common.domain.projectile.IProjectilePositioner;
	import iface.common.domain.projectile.ITarget;
	import iface.common.domain.reward.IRewardExecutor;
	import iface.common.domain.reward.IRewardManager;
	import iface.common.domain.reward.IRewardManagerFactory;
	import iface.common.domain.score.IScoreManager;
	import iface.common.domain.score.IScoreManagerFactory;
	import impl.common.domain.city.City;
	import impl.common.domain.dictionary.Dictionary;
	import impl.common.domain.enemy.EnemyFactory;
	import impl.common.domain.enemy.Word;
	import impl.common.domain.highscore.Highscore;
	import impl.common.domain.highscore.HighscoreManager;
	import impl.common.domain.level.Level;
	import impl.common.domain.level.LevelFactory;
	import impl.common.domain.powerup.PowerUpFactory;
	import impl.common.domain.powerup.PowerUpManager;
	import impl.common.domain.projectile.Projectile;
	import impl.common.domain.reward.RewardManager;
	import impl.common.domain.score.ScoreManager;

	
	/**
	 * ...
	 * @author ...
	 */
	public class GameFactory implements IHighscoreFactory, IProjectileFactory, IRewardManagerFactory, IScoreManagerFactory, IPowerUpManagerFactory, IGameFactory
	{
		private var appConfig:IApplicationConfiguration = null;
		private var animationEngine:IAnimationEngine = null;
		
		public function GameFactory(appConfig:IApplicationConfiguration) 
		{
			this.appConfig = appConfig;
			this.animationEngine = animationEngine;
		}

		public function createGame():IGame
		{
			return new Game( appConfig.getGameUpdatesPerSecond(), this.createLevelFactory(), this, this);
		}
		
		public function createPowerUpManager(specialPowerUpNotifier:ISpecialPowerUpNotifier, powerUpCommandExecutor:IPowerUpCommandExecutor):IPowerUpManager
		{
			return new PowerUpManager(createPowerUpFactory(specialPowerUpNotifier, powerUpCommandExecutor), this.appConfig.getMaxNumPowerUps());
		}
		
		public function createRewardManager( rewardExectutor:IRewardExecutor ):IRewardManager
		{
			return new RewardManager( this.appConfig.getLevelRewardThreshold(), this.appConfig.getScoreRewardThreshold(), rewardExectutor );
		}

		public function createScoreManager( rewardManager:IRewardManager ):IScoreManager
		{
			return new ScoreManager(	this.appConfig.getNonExsistantLetterAmount(), this.appConfig.getTypoAmount(), 
										this.appConfig.getPerCharacterAmount(), this.appConfig.getBombAmount(), 
										this.appConfig.getPerBonusWordCharacterFactor(), this.appConfig.getPerMissingCharacterBonusFactor(), 
										this.appConfig.getPerCharacterBonusAmountForNoUndroppedCharacters(), rewardManager );
		}
		
		public function createProjectile( target:ITarget, targetAltitude:Number, projectilePositioner:IProjectilePositioner ):IProjectile
		{
			return new Projectile( appConfig.getProjectileVelocity(), target, targetAltitude, projectilePositioner );
		}
		
		public function createHighscoreManager():IHighscoreManager
		{
			return new HighscoreManager(this);
		}
		
		public function createHighscore( name:String, score:int ):IHighscore
		{
			return new Highscore( name, score );
		}
		
		private function createLevelFactory():ILevelFactory
		{
			return new LevelFactory(	appConfig.getGameUpdatesPerSecond(), this.appConfig.getCityYOffset(), 
										createEnemyFactory(createDictionary()), createCity(), 
										this.appConfig.getPlayAreaWidth(), this.appConfig.getPlayAreaHeight(), 
										this.appConfig.getEnemyStartY(), this, this.appConfig.getLevelRewardThreshold(), 
										this.appConfig.getScoreRewardThreshold() );
		}
		
		private function createCity():ICity
		{
			return new City( 	this.appConfig.getPlayAreaWidth(), this.appConfig.getCityYOffset(), 
								this.appConfig.getMaxBuildingHeight(), this.appConfig.getMinBuildingWidth(), 
								this.appConfig.getMaxBuildingWidth(), this );
		}
		
		private function createEnemyFactory( dictionary:IDictionary ):IEnemyFactory
		{
			return new EnemyFactory( dictionary, appConfig.getEnemySizeComputer(), this.appConfig.getTicksForExnemyExplosion(), this.appConfig.getPlayAreaWidth(), this.appConfig.getMillisecondsPerTick() );
		}
		
		private function createDictionary():IDictionary
		{
			return new Dictionary();
		}
		
		private function createPowerUpFactory(specialPowerUpNotifier:ISpecialPowerUpNotifier, powerUpCommandExecutor:IPowerUpCommandExecutor):PowerUpFactory
		{
			return new PowerUpFactory( specialPowerUpNotifier, powerUpCommandExecutor, appConfig );
		}
		
	}
	
}