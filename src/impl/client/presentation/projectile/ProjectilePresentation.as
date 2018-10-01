package impl.client.presentation.projectile 
{
	import flash.display.Sprite;
	import iface.client.presentation.projectile.IProjectilePresentation;
	import iface.client.presentation.projectile.IProjectilePresentationListener;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.projectile.IProjectileListener;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ProjectilePresentation implements IProjectileListener, IProjectilePresentation
	{
		private var projectileSprite:Sprite = new Sprite();
		private var projectilePresentationListeners:Array = new Array();
		private var projectileCanvas:ICanvas = null;
		
		public function ProjectilePresentation( canvasFactory:ICanvasFactory, projectile:IProjectile, width:int, height:int ) 
		{
			this.projectileSprite.graphics.beginFill( 0xFFFFFF );
			this.projectileSprite.graphics.drawRect( 0, 0, width, height );
			this.projectileSprite.graphics.endFill();
			
			this.projectileSprite.x = projectile.getPosition().x;
			this.projectileSprite.y = projectile.getPosition().y;
			
			this.projectileCanvas = canvasFactory.createCanvasFromSprite( this.projectileSprite );
			
			projectile.addProjectileListener(this);
		}
		
		public function getCanvas():ICanvas
		{
			return this.projectileCanvas;
		}
		
		public function addProjectilePresentationListener( projectilePresentationListener:IProjectilePresentationListener ):void
		{
			projectilePresentationListeners.push( projectilePresentationListener );
		}
		
		public function targetHit():void
		{
			this.fireTargetHitEvent();
		}
		
		public function moved( newX:Number, newY:Number ):void
		{
			this.projectileSprite.x = newX;
			this.projectileSprite.y = newY;
		}
		
		private function fireTargetHitEvent():void
		{
			if ( projectilePresentationListeners[0] != null )
				projectilePresentationListeners[0].targetHit( projectileCanvas );
		}
	}
	
}