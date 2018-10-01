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
	public class PausePowerUpPresentation extends PowerUpPresentation implements IPowerUpPresentation
	{
		public function PausePowerUpPresentation(canvasFactory:ICanvasFactory, powerUpWidth:int, powerUpHeight:int, powerUpPauseSound:IGameSound, powerUpTextFormat:TextFormat) 
		{
			super( canvasFactory, powerUpWidth, powerUpHeight, powerUpPauseSound, powerUpTextFormat, "P" );
		}
	}
	
}