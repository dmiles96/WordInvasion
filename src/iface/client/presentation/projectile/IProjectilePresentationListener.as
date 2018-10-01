package iface.client.presentation.projectile 
{
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IProjectilePresentationListener 
	{
		function targetHit( projectileCanvas:ICanvas ):void;
	}
	
}