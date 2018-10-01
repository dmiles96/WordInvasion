package iface.common.domain.city 
{
	import iface.common.domain.ICollisionDetector;
	import iface.common.domain.projectile.IProjectile;
	import iface.common.domain.projectile.ITarget;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ICity extends ICollisionDetector
	{
		function getHeights():Array;
		function damage( startX:int, endX:int ):void;
		function addCityListener( cityListener:ICityListener ):void;
		function getMaxHeight():int;
		function getVulnerableLocation():int;
		function repair():void;
		function addCityDestroyedListener( cityDestroyedListener:ICityDestroyedListener ):void;
		function fireProjectile( target:ITarget, targetAltitude:Number ):IProjectile;
	}
	
}