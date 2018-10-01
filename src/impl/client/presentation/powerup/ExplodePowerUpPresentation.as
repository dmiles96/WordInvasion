package impl.client.presentation.powerup 
{
	import flash.media.Sound;
	import flash.text.TextFormat;
	import iface.client.presentation.powerup.IPowerUpPresentation;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ExplodePowerUpPresentation extends PowerUpPresentation implements IPowerUpPresentation
	{
		public function ExplodePowerUpPresentation(canvasFactory:ICanvasFactory, powerUpWidth:int, powerUpHeight:int, powerUpExplodeSound:IGameSound, powerUpTextFormat:TextFormat) 
		{
			super( canvasFactory, powerUpWidth, powerUpHeight, powerUpExplodeSound, powerUpTextFormat, "E" );
		}
	}
	
}