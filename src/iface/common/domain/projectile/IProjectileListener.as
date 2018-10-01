package iface.common.domain.projectile 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IProjectileListener 
	{
		function moved( newX:Number, newY:Number ):void;
		function targetHit():void;
	}
	
}