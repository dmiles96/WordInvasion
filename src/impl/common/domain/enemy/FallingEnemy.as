package impl.common.domain.enemy 
{
	import flash.geom.Point;
	import iface.common.domain.enemy.EnemyDirection;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyListener;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.enemy.MoveResults;
	import iface.common.domain.ICollisionDetector;
	import iface.common.domain.projectile.ITarget;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FallingEnemy extends Enemy implements ITarget
	{
		private var collisionDetector:ICollisionDetector = null;
		private var collided:Boolean;
		private var velocity:Number = 0;
		private var fallingEnemyListeners:Array = new Array();
		
		public function FallingEnemy( data:String, positioner:IPositioner, collisionDetector:ICollisionDetector, velocityComputer:IVelocityComputer, width:int, height:int, ticksToExplode:int, velocity:Number)
		{
			super( data, width, height, ticksToExplode );

			this.collisionDetector = collisionDetector;
			this.velocity = velocity;
			
			positioner.initializePosition( EnemyDirection.DOWN_DIRECTION, getPosition(), width, height );
		}
		
		public function isCollided():Boolean
		{
			return this.collided;
		}
		
		public function move( moveFactor:Number ):int
		{
			if ( this.isPaused() )
			{
				return MoveResults.MOVE_FAILURE_PAUSED;				
			}
			else
			{
				var newY:Number = this.getY() + (this.velocity * moveFactor);
				
				if ( this.collisionDetector.collision( newY + this.getHeight(), this.getX(), this.getX() + this.getWidth() ))
				{
					this.collided = true;
					fireCollidedEvent();
					
					return MoveResults.MOVE_FAILURE_COLLISION;
				}
				else
				{
					this.setY( newY );
					
					return MoveResults.MOVE_SUCCESSFUL;
				}
			}
		}
		
		public override function addEnemyListener(enemyListener:IEnemyListener):void 
		{
			this.fallingEnemyListeners.push( enemyListener );
			
			super.addEnemyListener(enemyListener);
		}
		
		public function targetXPosition(moveFactor:Number):Number
		{
			super.markTargeted();
			
			return this.getX() + (this.getWidth() / 2);
		}
		
		private function fireCollidedEvent():void
		{
			if ( this.fallingEnemyListeners[0] != null )
				this.fallingEnemyListeners[0].collided();
		}
	}
	
}