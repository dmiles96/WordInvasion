package iface.client.presentation.powerup 
{
	import iface.client.service.video.ICanvas;
	import iface.common.domain.powerup.IPowerUpManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IPowerUpPresentationManagerFactory 
	{
		function createPowerUpPresentationManager( powerUpManager:IPowerUpManager, drawingSurface:ICanvas ):IPowerUpPresentationManager
	}
	
}