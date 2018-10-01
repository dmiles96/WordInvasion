package impl.client.service.video 
{
	import flash.events.TimerEvent;
	import iface.client.service.video.IRenderer;
	import iface.client.service.video.IUpdateRegion;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Renderer implements IRenderer
	{
		private var timerEvent:TimerEvent = null;
		private var updateRegion:IUpdateRegion = null;
		
		public function Renderer() 
		{
			
		}
		
		public function renderStart(e:TimerEvent):void
		{
			this.timerEvent = e;
		}

		public function render():void
		{
			var needsRedraw:Boolean = this.updateRegion.update();

			if( needsRedraw )
				this.timerEvent.updateAfterEvent();
		}
		
		public function renderEnd():void
		{
			this.timerEvent = null;
		}
		
		public function addUpdateRegion( updateRegion:IUpdateRegion ):void
		{
			this.updateRegion = updateRegion;
		}

	}
	
}