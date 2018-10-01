package iface.client.animation 
{
	import iface.client.service.video.ICanvas;
	import iface.common.time.ITickHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IAnimationEngine extends ITickHandler
	{
		function pause():void;
		function unPause():void;
		function runAnimation( newAnimation:IAnimation ):void;
		function addAnimationEngineListener( animationEngineListener:IAnimationEngineListener ):void;
		function createTranslateAnimation(numFrames:int, 
									targetObject:Object, 
									propertyName:String ):ITranslateAnimation;
		
		function createIndefiniteAnimation(ticksForMove:int, 
												valueDelta:Number, 
												targetObject:Object, 
												propertyName:String):IIndefiniteAnimation;
		
		function createIndefiniteFunctionAnimation(ticksForMove:int, 
												targetObject:Object, 
												func:Function):IIndefiniteAnimation;
												
		function createWaitAnimation(	ticksToWait:int, 
										targetObject:Object, 
										func:Function):IWaitAnimation

		function createDisplayObjectAnimation( imageContainer:ICanvas, images:Array, tickIntervalForImageDisplay:int, repeat:Boolean ):IAnimation;
	}
	
}