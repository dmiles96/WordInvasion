package impl.common.domain.enemy 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import iface.common.domain.Dimension;
	import iface.common.domain.enemy.IEnemy;
	import iface.common.domain.enemy.IEnemyListener;
	import iface.common.domain.enemy.IPositioner;
	import iface.common.domain.enemy.CharacterMatchResults;
	import iface.common.domain.IClipper;
	import iface.common.domain.ICollisionDetector;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Enemy /* abstract */
	{
		private var data:String = null;
		private var curCharIndex:int = 0;
		private var enemyListeners:Array = new Array();
		private var dead:Boolean = false;
		private var width:int = 0;
		private var height:int = 0;
		private var position:Point = new Point();
		private var destroyed:Boolean = false;
		private var paused:Boolean = false;
		private var rectangle:Rectangle = new Rectangle();
		private var exploding:Boolean = false;
		private var ticksToExplode:int = 0;
		private var tickExplsionCounter:Number = 0;
		private var exploded:Boolean = false;
		private var targeted:Boolean = false;
		
		public function Enemy( data:String, width:int, height:int, ticksToExplode:int ) 
		{
			this.data = data;
			this.width = width;
			this.height = height;
			this.rectangle.width = width;
			this.rectangle.height = height;
			this.ticksToExplode = ticksToExplode;
		}

		public function getX():Number
		{
			return position.x;
		}
		
		public function getY():Number
		{
			return position.y;
		}
		
		public function getWidth():int
		{
			return this.width;
		}
		
		public function getHeight():int
		{
			return this.height;
		}
		
		public function getData():String
		{
			return data;
		}

		public function getFirstChar():String
		{
			return this.data.charAt(0);
		}

		public function getNumChars():int
		{
			return this.data.length;
		}
		
		public function setX( x:Number ):void
		{
			this.position.x = x;
			
			this.fireMoveEvent(this.position.x, this.position.y);
		}
		
		public function setY( y:Number ):void
		{
			this.position.y = y;
			
			this.fireMoveEvent(this.position.x, this.position.y);
		}
		
		public function getPosition():Point
		{
			return this.position;
		}
		
		public function getRect():Rectangle
		{
			this.rectangle.x = this.position.x;
			this.rectangle.y = this.position.y;
			this.rectangle.width = this.width;
			this.rectangle.height = this.height;
			
			return this.rectangle;
		}
		
		public function getCharIndex():int
		{
			return this.curCharIndex;
		}
		
		public function updateDimensions( newDimension:Dimension ):void
		{
			this.width = newDimension.width;
			this.height = newDimension.height;
		}
		
		public function tickExplosion( tickDelta:Number ):Boolean
		{
			this.tickExplsionCounter += tickDelta;
			
			if ( this.tickExplsionCounter >= this.ticksToExplode )
			{
				this.exploded = true;
				return false;
			}
			
			return true;
		}
		
		public function matchNextChar( nextChar:String ):int
		{
			if ( data.charAt(curCharIndex) == nextChar ) 
			{
				curCharIndex++;
				fireUpdatedMatchedChars( this.curCharIndex );
				
				if ( this.curCharIndex == data.length )
				{
					return CharacterMatchResults.MATCH_COMPLETE
				}
				
				return CharacterMatchResults.MATCH_PENDING;
			}
			
			curCharIndex = 0;
			fireUpdatedMatchedChars( this.curCharIndex );
			
			return CharacterMatchResults.MATCH_FAILURE;
		}
		
		public function destroy():void
		{
			this.destroyed = true;
		}
		
		public function pause():void
		{
			this.paused = true;
		}
		
		public function unPause():void
		{
			this.paused = false;
		}
		
		public function isPaused():Boolean
		{
			return this.paused;
		}
		
		public function isDestroyed():Boolean
		{
			return this.destroyed;
		}
		
		public function isDead():Boolean
		{
			return this.dead;
		}
		
		public function hasMatchedChars():Boolean
		{
			return this.curCharIndex != 0;
		}

		public function die():void
		{
			this.dead = true;
			
			fireEnemyDiedEvent();
		}
		
		public function explode():void
		{
			this.exploding = true;
			
			fireEnemyExplodingEvent();
		}
		
		public function isExploded():Boolean
		{
			return this.exploded;
		}
		
		public function markTargeted():void
		{
			this.targeted = true;
		}
		
		public function isTargeted():Boolean
		{
			return this.targeted;
		}
		
		public function hit( y:Number ):Boolean
		{
			if ( y <= this.position.y )
			{
				this.destroy();
				
				return true;
			}
			
			return false;
		}
		
		public function addEnemyListener( enemyListener:IEnemyListener ):void
		{
			this.enemyListeners.push( enemyListener );
		}
		
		private function dispose():void
		{
			this.enemyListeners = null;
		}
		
		private function fireUpdatedMatchedChars( curCharIndex:int ):void
		{
			if( enemyListeners[0] != null )
				enemyListeners[0].numMatchedCharsUpdated( curCharIndex );
		}
		
		private function fireMoveEvent( x:int, y:int ):void
		{
			if( enemyListeners[0] != null )
				enemyListeners[0].moved( x, y );
		}
		
		private function fireEnemyDiedEvent():void
		{
			if( enemyListeners[0] != null )
				enemyListeners[0].enemyDied();
		}

		private function fireEnemyExplodingEvent():void
		{
			if( enemyListeners[0] != null )
				enemyListeners[0].enemyExploding(this);
		}
		
	}
	
}