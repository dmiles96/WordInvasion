package iface.common.domain.projectile 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IProjectileFactory 
	{
		function createProjectile( target:ITarget, targetAltitude:Number, projectilePositioner:IProjectilePositioner ):IProjectile;
	}
	
}