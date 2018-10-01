package iface.common.domain.enemy 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPositioner 
	{
		function initializePosition( direction:int, position:Point, width:int, height:int ):void
	}
	
}