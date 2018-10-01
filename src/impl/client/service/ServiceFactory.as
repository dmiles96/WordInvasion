package impl.client.service 
{
	import flash.events.TimerEvent;
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.service.audio.ISoundFactory;
	import iface.client.service.input.CommandKeyNameDatabase;
	import iface.client.service.input.IKeyboardHandler;
	import iface.client.service.IServiceFactory;
	import iface.client.service.timer.ITimer;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.service.video.IRenderer;
	import iface.client.service.video.IRenderFactory;
	import impl.client.service.input.KeyboardHandler;
	import impl.client.service.timer.Timer;
	import impl.client.service.video.CanvasFactory;
	import impl.client.service.video.Renderer;
	import impl.client.service.video.RenderFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ServiceFactory implements IServiceFactory
	{
		private var canvasFactory:ICanvasFactory = null;
		private var rendererFactory:IRenderFactory = null;
		private var keyboardHandler:IKeyboardHandler = null;
		private var soundFactory:ISoundFactory = null;
		
		public function ServiceFactory(	canvasFactory:ICanvasFactory, appConfig:IApplicationConfiguration, soundFactory:ISoundFactory ) 
		{
			this.canvasFactory = canvasFactory;
			this.rendererFactory = new RenderFactory();
			this.keyboardHandler = new KeyboardHandler(canvasFactory, new CommandKeyNameDatabase() );
			this.soundFactory = soundFactory;
		}
		
		public function getCanvasFactory():ICanvasFactory 
		{
			return canvasFactory;
		}
		
		public function createTimer():ITimer
		{
			return new Timer(rendererFactory.createRenderer());
		}
		
		public function getKeyboardHandler():IKeyboardHandler
		{
			return this.keyboardHandler;
		}
		
		public function getRenderFactory():IRenderFactory
		{
			return this.rendererFactory;
		}
		
		public function getSoundFactory():ISoundFactory
		{
			return this.soundFactory;
		}
	}
	
}