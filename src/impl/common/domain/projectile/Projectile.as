package impl.common.domain.projectile 
{
	import flash.geom.Point;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.projectile.IProjectileListener;
	import iface.common.domain.projectile.IProjectilePositioner;
	import iface.common.domain.projectile.ITarget;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Projectile implements IProjectile
	{
		private var position:Point = null;
		private var velocity:Number = 0;
		private var target:ITarget = null;
		private var projectileListeners:Array = new Array();
		
		public function Projectile( velocity:Number, target:ITarget, targetAltitude:Number, projectilePositioner:IProjectilePositioner ) 
		{
			this.velocity = velocity;
			this.position = position;
			this.target = target;
			
			var ticksToReachTargetAltitude:Number = targetAltitude / this.velocity;
			var x:Number = this.target.targetXPosition(ticksToReachTargetAltitude);
			var y:Number = projectilePositioner.getAltitude(x);
			
			this.position = new Point( x, y );
		}
		
		public function move( moveFactor:Number ):Boolean
		{
			var newY:Number = this.position.y - (this.velocity * moveFactor);

			if ( target.hit( newY ))
			{
				this.fireTargetHitEvent();
				
				return false;
			}
			
			this.position.y = newY;
			this.fireMovedEvent();
			
			return true;
		}
		
		public function getPosition():Point
		{
			return this.position;
		}
		
		public function addProjectileListener( projectileListener:IProjectileListener ):void
		{
			projectileListeners.push( projectileListener );
		}
		
		private function fireMovedEvent():void
		{
			if ( this.projectileListeners[0] != null )
				this.projectileListeners[0].moved( position.x, position.y );
		}
		
		private function fireTargetHitEvent():void
		{
			if ( this.projectileListeners[0] != null )
				this.projectileListeners[0].targetHit();
		}		
		
	}
	
}