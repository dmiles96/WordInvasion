package iface.client.presentation 
{
	import iface.client.animation.IAnimationEngine;
	import iface.client.service.video.IUpdateableCanvas;
	import iface.common.domain.IGame;
	import impl.client.presentation.GamePresentation;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IGamePresentationFactory 
	{
		function createGamePresentation( game:IGame, drawingSurface:IUpdateableCanvas ):IGamePresentation;
	}
	
}