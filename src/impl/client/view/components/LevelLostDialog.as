package impl.client.view.components 
{
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.components.IDialog;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LevelLostDialog extends SpaceBarDialog implements IDialog
	{
		public function LevelLostDialog(canvasFactory:ICanvasFactory, location:Point, standardTextFormat:TextFormat, width:int, height:int) 
		{
			super( canvasFactory, location, "Game Over", standardTextFormat, width, height );
		}
	}
	
}