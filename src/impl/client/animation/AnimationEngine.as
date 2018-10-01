package impl.client.animation 
{
	import iface.client.animation.IAnimation;
	import iface.client.animation.IAnimationEngine;
	import iface.client.animation.IAnimationEngineListener;
	import iface.client.animation.IIndefiniteAnimation;
	import iface.client.animation.ITranslateAnimation;
	import iface.client.animation.IWaitAnimation;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.IUpdateRegion;
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AnimationEngine implements IAnimationEngine
	{
		private var runningAnimations:Array = new Array();
		private var updateRegion:IUpdateRegion = null;
		private var animationEngineListeners:Array = new Array();
		private var paused:Boolean = false;
		
		public function AnimationEngine() 
		{
		}

		public function tick( tickDelta:int ):void
		{
			if ( !this.paused )
			{
				var numOfAnimations:int = this.runningAnimations.length;

				for ( var animationIndex:int = numOfAnimations; animationIndex > 0; animationIndex-- )
				{
					var animation:IAnimation = this.runningAnimations.shift();
					
					if ( !animation.isPaused() )
					{
						animation.tick(tickDelta);
					}
					
					if ( animation.isDone() )
					{
						animation = null;
					}
					else
					{
						this.runningAnimations.push( animation );
					}
				}
				
				if ( numOfAnimations > 0 )
				{
					fireFrameCompletedEvent(true);
				}
				else
				{
					fireFrameCompletedEvent(false);
				}
			}
		}
		
		public function pause():void
		{
			this.paused = true;
		}
		
		public function unPause():void
		{
			this.paused = false;
		}
		
		public function addAnimationEngineListener( animationEngineListener:IAnimationEngineListener ):void
		{
			this.animationEngineListeners.push(animationEngineListener);
		}
		
		private function fireFrameCompletedEvent( animationsOccured:Boolean ):void
		{
			for each( var animationEngineListener:IAnimationEngineListener in this.animationEngineListeners )
			{
				animationEngineListener.frameCompleted(animationsOccured);
			}
		}
		
		public function createTranslateAnimation(numFrames:int, 
									targetObject:Object, 
									propertyName:String ):ITranslateAnimation
		{
			var newAnimation:ITranslateAnimation = new TranslateAnimation(numFrames, targetObject, propertyName );
				
			return newAnimation;
		}
		
		public function createIndefiniteAnimation(ticksForMove:int, 
												valueDelta:Number, 
												targetObject:Object, 
												propertyName:String):IIndefiniteAnimation
		{
			var newAnimation:IIndefiniteAnimation = new IndefiniteAnimation(	ticksForMove, 
																	valueDelta, 
																	targetObject, 
																	propertyName );
				
			return newAnimation;
		}
		
		public function createIndefiniteFunctionAnimation(ticksForMove:int, 
												targetObject:Object, 
												func:Function):IIndefiniteAnimation
		{
			var newAnimation:IIndefiniteAnimation = new IndefiniteFunctionAnimation(	ticksForMove, 
																	targetObject, 
																	func );
				
			return newAnimation;
		}
		
		public function createWaitAnimation(	ticksToWait:int, 
															targetObject:Object, 
															func:Function):IWaitAnimation
		{
			var newAnimation:IWaitAnimation = new WaitAnimation(	ticksToWait, 
																targetObject, 
																func );
				
			return newAnimation;
		}
		
		public function createDisplayObjectAnimation( imageContainer:ICanvas, images:Array, tickIntervalForImageDisplay:int, repeat:Boolean ):IAnimation
		{
			var newAnimation:DisplayObjectAnimation = new DisplayObjectAnimation(	imageContainer, 
																					images, 
																					tickIntervalForImageDisplay,
																					repeat);
				
			return newAnimation;
		}
		
		public function runAnimation( newAnimation:IAnimation ):void
		{
			this.runningAnimations.push( newAnimation );
			newAnimation.run();
		}
	}
	
}