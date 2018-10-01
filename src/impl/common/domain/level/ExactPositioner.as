package impl.common.domain.level 
{
	import flash.geom.Point;
	import iface.common.domain.enemy.IPositioner;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ExactPositioner implements IPositioner
	{
		private var x:int = 0;
		private var y:int = 0;
		
		public function ExactPositioner() 
		{
			
		}
		
		public function updatePosition( x:int, y:int ):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function initializePosition( direction:int, position:Point, width:int, height:int ):void
		{
			position.x = this.x;
			position.y = this.y;
		}
	}
	
}