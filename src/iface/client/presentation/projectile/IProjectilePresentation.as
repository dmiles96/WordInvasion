package iface.client.presentation.projectile 
{
	import flash.display.Sprite;
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IProjectilePresentation 
	{
		function getCanvas():ICanvas;
		function addProjectilePresentationListener( projectilePresentationListener:IProjectilePresentationListener ):void;
	}
	
}