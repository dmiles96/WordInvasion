package iface.common.domain.projectile 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITarget 
	{
		function hit( y:Number ):Boolean;
		function targetXPosition(moveFactor:Number):Number
	}
	
}