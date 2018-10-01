package iface.client.presentation.city 
{
	import iface.client.presentation.projectile.IProjectilePresentation;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ICityPresentationListener 
	{
		function projectileFired( projectilePresentation:IProjectilePresentation ):void;
	}
	
}