package iface.common.domain.projectile 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IProjectile 
	{
		function addProjectileListener( projectileListener:IProjectileListener ):void;
		function move( moveFactor:Number ):Boolean;
		function getPosition():Point;
	}
	
}