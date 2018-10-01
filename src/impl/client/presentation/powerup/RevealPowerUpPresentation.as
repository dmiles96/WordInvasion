package impl.client.presentation.powerup 
{
	import flash.display.CapsStyle;
    import flash.display.LineScaleMode;		
	import flash.media.Sound;
	import flash.text.TextFormat;
	import iface.client.presentation.powerup.IPowerUpPresentation;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvasFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RevealPowerUpPresentation extends PowerUpPresentation implements IPowerUpPresentation
	{
		public function RevealPowerUpPresentation(canvasFactory:ICanvasFactory, powerUpWidth:int, powerUpHeight:int, powerUpRevealSound:IGameSound, powerUpTextFormat:TextFormat) 
		{
			super( canvasFactory, powerUpWidth, powerUpHeight, powerUpRevealSound, powerUpTextFormat, "R" );
		}
		
	}
	
}