package impl.common.domain.enemy 
{
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.IVelocityComputer;
	import iface.common.domain.IClipper;
	import iface.common.domain.ICollisionDetector;
	import iface.common.domain.enemy.EnemyDirection;
	import iface.common.domain.enemy.MoveResults;
	import iface.common.domain.projectile.ITarget;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class FlyingEnemy extends Enemy implements ITarget
	{
		private var clipper:IClipper = null;
		private var direction:int = EnemyDirection.LEFT_DIRECTION;
		private var escaped:Boolean = false;
		private var velocity:Number = 0;
		private var playAreaWidth:int = 0; 
		private var millisecondsPerTick:int = 0;
		
		public function FlyingEnemy(data:String, positioner:IPositioner, clipper:IClipper, velocityComputer:IVelocityComputer, width:int, height:int, ticksToExplode:int, playAreaWidth:int, millisecondsPerTick:int, velocity:Number )
		{
			super( data, width, height, ticksToExplode );

			this.clipper = clipper;
			this.playAreaWidth = playAreaWidth;
			this.millisecondsPerTick = millisecondsPerTick;
			
			if ( Math.round( Math.random() ) > 0 )
			{
				this.direction = EnemyDirection.RIGHT_DIRECTION;
			}
			
			this.velocity = velocity
			
			positioner.initializePosition( direction, getPosition(), width, height );
		}
		
		public function isEscaped():Boolean
		{
			return this.escaped;
		}
		
		public function move( moveFactor:Number ):int
		{
			if ( this.isPaused() )
			{
				return MoveResults.MOVE_FAILURE_PAUSED;
			}
			else
			{
				if ( this.direction == EnemyDirection.LEFT_DIRECTION )
					return this.moveLeft( moveFactor );
				else
					return this.moveRight( moveFactor );
			}
		}
		
		public function getMillisecondsTillOffScreen():int
		{
			var distanceToTravel:int = 0;
			
			//Still don't understand these calculations, but they work. Their may be rounding errors invovled
			//when calculating loops that force these to be to big in order to compensate.
			if ( this.direction == EnemyDirection.LEFT_DIRECTION )
				distanceToTravel = this.playAreaWidth + (this.getWidth()) + (this.getWidth() / 2);
			else if ( this.direction == EnemyDirection.RIGHT_DIRECTION )
				distanceToTravel = this.playAreaWidth + (this.getWidth());
			
			var ticksToTravel:Number = distanceToTravel / this.velocity;
			
			return ticksToTravel * this.millisecondsPerTick;
		}
		
		public function targetXPosition(moveFactor:Number):Number
		{
			super.markTargeted();

			if ( this.direction == EnemyDirection.LEFT_DIRECTION )
				return (this.getX() + (this.getWidth() / 2)) - (this.velocity * moveFactor);
			else
				return (this.getX() + (this.getWidth() / 2)) + (this.velocity * moveFactor);
		}			
		
		private function moveLeft( moveFactor:Number ):int
		{
			var newX:Number = this.getX() - (this.velocity * moveFactor);

			return doMove(newX);
		}

		private function moveRight( moveFactor:Number):int
		{
			var newX:Number = this.getX() + (this.velocity * moveFactor);

			return doMove(newX);
		}

		private function doMove( newX:Number ):int
		{
			if ( (this.clipper.isOffScreen( newX, this.getY(), this.getWidth(), this.getHeight() )) && !isTargeted())
			{
				this.escaped = true;
				
				return MoveResults.MOVE_FAILURE_OFFSCREEN;
			}
			else
			{
				this.setX( newX );
				
				return MoveResults.MOVE_SUCCESSFUL;
			}
		}
	}
	
}