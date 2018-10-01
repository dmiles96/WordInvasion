package impl.client.service.video 
{
	import iface.client.service.video.IRenderer;
	import iface.client.service.video.IRenderFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class RenderFactory implements IRenderFactory
	{
		private var renderer:IRenderer = null;
		
		public function RenderFactory() 
		{
			
		}

		public function createRenderer():IRenderer
		{
			if( renderer == null )
				renderer = new Renderer();
			
			return renderer;
		}
	}
	
}