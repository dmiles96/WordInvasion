package impl.client.service.video 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.IUpdateableCanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CanvasFactory implements ICanvasFactory
	{
		private var mainCanvas:ICanvas = null;
		
		public function CanvasFactory(mainSprite:Sprite) 
		{
			this.mainCanvas = new Canvas(mainSprite);
		}
		
		public function createCanvas():ICanvas
		{
			return new Canvas(null);
		}
		
		public function getMainCanvas(): ICanvas
		{
			return this.mainCanvas;
		}

		public function createCanvasFromSprite( sprite:Sprite ):ICanvas
		{
			return new Canvas(sprite);
		}
		
		public function createUpdateableCanvas():IUpdateableCanvas
		{
			return new UpdateableCanvas(null);
		}
	}
	
}