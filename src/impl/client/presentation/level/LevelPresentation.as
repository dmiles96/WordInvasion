package impl.client.presentation.level 
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import iface.client.animation.IAnimationEngine;
	import iface.client.animation.IIndefiniteAnimation;
	import iface.client.presentation.city.ICityPresentation;
	import iface.client.presentation.city.ICityPresentationListener;
	import iface.client.presentation.enemy.IEnemyPresentation;
	import iface.client.presentation.enemy.IEnemyPresentationFactory;
	import iface.client.presentation.enemy.IEnemyPresentationListener;
	import iface.client.presentation.level.ILevelPresentation;
	import iface.client.presentation.level.ILevelPresentationListener;
	import iface.client.presentation.powerup.IPowerUpPresentationManager;
	import iface.client.presentation.powerup.IPowerUpPresentationManagerFactory;
	import iface.client.presentation.powerup.IPowerUpPresentationManagerListener;
	import iface.client.presentation.projectile.IProjectilePresentation;
	import iface.client.presentation.projectile.IProjectilePresentationListener;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyFactory;
	import iface.common.domain.level.ILevel;
	import iface.common.domain.level.ILevelListener;
	import iface.common.domain.powerup.IPowerUpManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelPresentation implements IProjectilePresentationListener, ICityPresentationListener, IEnemyPresentationListener, IPowerUpPresentationManagerListener, ILevelPresentation, ILevelListener
	{
		private var enemyPresentations:Array = new Array();
		private var animationEngine:IAnimationEngine = null;
		private var enemyPresentationFactory:IEnemyPresentationFactory = null;
		private var levelCanvas:ICanvas = null;
		private var cityPresentation:ICityPresentation = null;
		private var powerUpPresentationManager:IPowerUpPresentationManager = null;
		private var levelPresentationListeners:Array = new Array();
		private var typoSound:IGameSound = null;
		
		public function LevelPresentation( 	animationEngine:IAnimationEngine, enemyPresentationFactory:IEnemyPresentationFactory, 
											level:ILevel, canvasFactory:ICanvasFactory, cityPresentation:ICityPresentation, 
											cityYOffset:int, powerUpManager:IPowerUpManager, 
											powerUpPresentationManagerFactory:IPowerUpPresentationManagerFactory,
											typoSound:IGameSound)
		{
			this.animationEngine = animationEngine;
			this.enemyPresentationFactory = enemyPresentationFactory;
			this.cityPresentation = cityPresentation;
			this.typoSound = typoSound;
			
			this.levelCanvas = canvasFactory.createCanvas();
			this.levelCanvas.addCanvas( canvasFactory.createCanvasFromSprite( cityPresentation.getDisplay() ));			
			this.cityPresentation.getDisplay().y = cityYOffset;
			this.powerUpPresentationManager = powerUpPresentationManagerFactory.createPowerUpPresentationManager( powerUpManager, levelCanvas );
			
			level.addLevelListener(this);
			powerUpPresentationManager.addPowerUpPresentationManagerListener(this);
			this.cityPresentation.addCityPresentationListener(this);
		}

		public function start():void
		{

		}

		public function addLevelPresentationListener( levelPresentationListener:ILevelPresentationListener ):void
		{
			this.levelPresentationListeners.push( levelPresentationListener );
		}

		public function enemyCreated( enemy:IEnemy ):void
		{
			var newEnemyPresentation:IEnemyPresentation = enemyPresentationFactory.createEnemyPresentation( enemy );
			
			newEnemyPresentation.addEnemyPresentationListener(this);
			
			this.enemyPresentations.push( newEnemyPresentation );
			newEnemyPresentation.present( this.levelCanvas );
			
			this.fireLevelUpdatedEvent();
		}
		
		public function enemyDeath( enemy:IEnemy ):void
		{
		}
		
		public function getCanvas():ICanvas
		{
			return this.levelCanvas;
		}
		
		public function dead( enemyPresentation:IEnemyPresentation ):void
		{
			this.levelCanvas.removeCanvas( enemyPresentation.getCanvas() );
			this.fireLevelUpdatedEvent();
		}
		
		public function enemiesMoved( numEnemiesMoved:int ):void
		{
			if ( numEnemiesMoved > 0 )
				this.fireLevelUpdatedEvent();
		}
		
		public function powerUpsUpdated():void
		{
			this.fireLevelUpdatedEvent();
		}

		public function projectileFired( projectilePresentation:IProjectilePresentation ):void
		{
			this.levelCanvas.addCanvas( projectilePresentation.getCanvas() );
			
			projectilePresentation.addProjectilePresentationListener(this);
		}
		
		public function targetHit( projectileCanvas:ICanvas ):void
		{
			this.levelCanvas.removeCanvas( projectileCanvas );
		}
		
		public function typo():void
		{
			trace("typosound");
			this.typoSound.play();
		}
		
		private function fireLevelUpdatedEvent():void
		{
			if ( this.levelPresentationListeners[0] != null )
				this.levelPresentationListeners[0].levelUpdated();
		}
	}
	
}