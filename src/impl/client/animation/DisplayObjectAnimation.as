package impl.client.animation 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import iface.client.animation.IAnimation;
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DisplayObjectAnimation extends Animation implements IAnimation
	{
		private var imageContainer:ICanvas = null;
		private var images:Array = null;
		private var tickIntervalForImageDisplay:int = 0;
		private var repeat:Boolean = true;
		private var imageDisplayTickCounter:Number = 0;
		private var imageIndex:int = 0;
		private var prevDisplayObject:DisplayObject = null;
		
		public function DisplayObjectAnimation(imageContainer:ICanvas, images:Array, tickIntervalForImageDisplay:int, repeat:Boolean) 
		{
			this.imageContainer = imageContainer;
			this.images = images
			this.tickIntervalForImageDisplay = tickIntervalForImageDisplay;
			this.repeat = repeat;
		}
		
		public override function run():void
		{
			this.prevDisplayObject = images[imageIndex];
			this.imageContainer.addChild( images[imageIndex] );
		}
		
		public override function tick( tickDelta:int ):void
		{
			this.imageDisplayTickCounter += tickDelta;
			
			while ( imageDisplayTickCounter >= tickIntervalForImageDisplay )
			{
				imageIndex++;
				
				if ( !(imageIndex < this.images.length) )
				{
					if( this.repeat )
						imageIndex = 0;
					else
					{
						this.done();
						break;
					}
				}
				
				if( this.prevDisplayObject != null )
					this.imageContainer.removeChild( prevDisplayObject );
				
				this.imageContainer.addChild( this.images[imageIndex] );
				this.prevDisplayObject = this.images[imageIndex];
				
				imageDisplayTickCounter = 0;
			}
		}		
	}
	
}