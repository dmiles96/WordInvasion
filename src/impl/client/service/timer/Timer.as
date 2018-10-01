package impl.client.service.timer
{
	import flash.events.TimerEvent;
	import iface.client.service.IServiceFactory;
	import flash.utils.Timer;
	import iface.client.service.timer.ITimer;
	import iface.client.service.timer.ITimerHandler;
	import iface.client.service.video.IRenderer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Timer implements ITimer
	{
		private var flashTimer:flash.utils.Timer = null;
		private var timerTickHandler:ITimerHandler = null;
		private var renderer:IRenderer = null;
		
		public function Timer(renderer:IRenderer) 
		{
			this.renderer = renderer;
		}
		
		public function start(millisecondsPerTick:int, timerTickHandler:ITimerHandler):void
		{
			this.stop();
			
			this.flashTimer = new flash.utils.Timer(millisecondsPerTick, 0);
			
			this.timerTickHandler = timerTickHandler;
			this.flashTimer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
			this.flashTimer.start();
		}
		
		public function stop():void
		{
			if ( flashTimer != null )
			{
				this.flashTimer.stop();
				this.flashTimer.removeEventListener(TimerEvent.TIMER, timerHandler );
				this.flashTimer = null;
			}
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			renderer.renderStart(e);
			timerTickHandler.timerTick(0, renderer);
		}
		
	}
	
}