package iface.common.domain.city 
{
	import iface.common.domain.projectile.IProjectile;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ICityListener 
	{
		function damaged( heights:Array, damageStart:int, damageEnd:int ):void;
		function repaired( heights:Array, repairStart:int, repairEnd:int ):void;
		function projectileFired( projectile:IProjectile ):void;
	}
	
}