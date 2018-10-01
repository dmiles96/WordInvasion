package impl.client.presentation.powerup 
{
	import flash.geom.Point;
	import iface.client.presentation.powerup.IPowerUpPresentation;
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PowerUpPresentationSlot 
	{
		private var position:Point = null;
		private var powerUpPresentation:IPowerUpPresentation = null;
		private var drawingSurface:ICanvas = null;
		
		public function PowerUpPresentationSlot(drawingSurface:ICanvas, position:Point) 
		{
			this.position = position;
			this.drawingSurface = drawingSurface;
		}
		
		public function fill( powerUpPresentation:IPowerUpPresentation ):void
		{
			this.powerUpPresentation = powerUpPresentation;
			
			this.powerUpPresentation.getCanvas().setX( position.x );
			this.powerUpPresentation.getCanvas().setY( position.y );

			this.drawingSurface.addCanvas(powerUpPresentation.getCanvas());
		}
		
		public function empty():IPowerUpPresentation
		{
			var curPowerUpPresentation:IPowerUpPresentation = this.powerUpPresentation;
			
			this.drawingSurface.removeCanvas(this.powerUpPresentation.getCanvas());
			this.powerUpPresentation = null;
			
			return curPowerUpPresentation;
		}
	}
	
}