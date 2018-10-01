package impl.common.domain.city 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class CitySegment 
	{
		private var startX:int = 0;
		private var endX:int = 0;
		
		public function CitySegment(startX:int, endX:int) 
		{
			this.startX = startX;
			this.endX = endX;
		}
		
		public function getStartX():int
		{
			return this.startX;
		}
		
		public function getEndX():int
		{
			return this.endX;
		}
		
		public function setStartX( newStartX:int ):void
		{
			this.startX = newStartX;
		}
		
		public function setEndX( newEndX:int ):void
		{
			this.endX = newEndX;
		}
	}
	
}