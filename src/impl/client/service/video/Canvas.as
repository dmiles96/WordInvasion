package impl.client.service.video 
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import iface.client.service.video.ICanvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Canvas implements ICanvas
	{
		private var sprite:Sprite = null;
		
		public function Canvas(sprite:Sprite) 
		{
			if ( sprite == null )
				this.sprite = new Sprite();
			else
				this.sprite = sprite;
		}
		
		public function addCanvas( canvas:ICanvas ):void
		{
			var otherCanvas:Canvas = canvas as Canvas;
			var otherSprite:Sprite = otherCanvas.getInternalSprite();
			
			sprite.addChild(otherSprite);
		}

		public function removeCanvas( canvas:ICanvas ):void
		{
			var otherCanvas:Canvas = canvas as Canvas;
			var otherSprite:Sprite = otherCanvas.getInternalSprite();
			
			sprite.removeChild(otherSprite);
		}
		
		public function addChild( displayObject:DisplayObject ):void
		{
			sprite.addChild( displayObject );
		}

		public function removeChild( displayObject:DisplayObject ):void
		{
			sprite.removeChild( displayObject );
		}

		public function clear():void
		{
		}
		
		public function getInternalSprite():Sprite
		{
			return this.sprite;
		}

		public function setX( newX:Number ):void
		{
			this.sprite.x = newX;
		}
		
		public function setY( newY:Number ):void
		{
			this.sprite.y = newY;
		}

		public function getWidth():Number
		{
			return this.sprite.width;
		}
		
		public function getHeight():Number
		{
			return this.sprite.height;
		}
		
		public function getGraphics():Graphics
		{
			return this.sprite.graphics;
		}
		
		public function takeFocus():void
		{
			this.sprite.stage.focus = this.sprite;
		}
		
		public function setWidth( width:Number ):void
		{
			this.sprite.width = width;
		}
		
		public function setHeight( height:Number ):void
		{
			this.sprite.height = height;
		}
		
		public function getY():Number
		{
			return this.sprite.y;
		}
	}
	
}