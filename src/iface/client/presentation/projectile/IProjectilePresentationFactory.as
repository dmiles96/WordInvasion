package iface.client.presentation.projectile 
{
	import iface.common.domain.projectile.IProjectile;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IProjectilePresentationFactory 
	{
		function createProjectilePresentation( projectile:IProjectile ):IProjectilePresentation;
	}
	
}