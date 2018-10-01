package impl.client.service.video 
{
	import flash.display.Sprite;
	import iface.client.service.video.IUpdateableCanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UpdateableCanvas extends Canvas implements IUpdateableCanvas
	{
		private var dirty:Boolean = false;
		
		public function UpdateableCanvas(sprite:Sprite) 
		{
			super(sprite);
		}
		
		public function update():Boolean
		{
			var prevDirty:Boolean = dirty;
			
			dirty = false;

			return prevDirty;
		}
		
		public function markDirty():void
		{
			dirty = true;
		}
	}
	
}