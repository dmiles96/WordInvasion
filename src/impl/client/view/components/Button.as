package impl.client.view.components 
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.ClickEvent;
	import  iface.client.view.IClickHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Button 
	{
		private var buttonCanvas:ICanvas = null;
		private var clickHandler:IClickHandler = null;
		private var buttonTextField:TextField = new TextField();
		private var clickData:String = null;
		private var minButtonWidth:int = 64;
		private var minButtonHeight:int = 24;
		private var buttonTextWidthPadding:int = 20;
		private var buttonTextHeightPadding:int = 10;
		
		public function Button( canvasFactory:ICanvasFactory, text:String, clickHandler:IClickHandler, textFormat:TextFormat, clickData:String )
		{
			this.clickHandler = clickHandler;
			this.clickData = clickData;
			
			var buttonSprite:Sprite = new Sprite();

			this.buttonTextField.selectable = false;
			this.buttonTextField.embedFonts = true;
			this.buttonTextField.autoSize = TextFieldAutoSize.LEFT;
			this.buttonTextField.type = TextFieldType.DYNAMIC;
			this.buttonTextField.text = text;
			this.buttonTextField.setTextFormat( textFormat );	
			
			this.buttonTextField.addEventListener(Event.ADDED_TO_STAGE, init);

			var buttonSpriteWidth:int = 0;
			var buttonSpriteHeight:int = 0;
			
			buttonSpriteWidth = this.buttonTextField.width + this.buttonTextWidthPadding;
			buttonSpriteHeight = this.buttonTextField.height + this.buttonTextHeightPadding;
			
			if ( buttonSpriteWidth < this.minButtonWidth )
				buttonSpriteWidth = this.minButtonWidth;
				
			if ( buttonSpriteHeight < this.minButtonHeight )
				buttonSpriteHeight = this.minButtonHeight;
				
			this.buttonTextField.x = (buttonSpriteWidth / 2) - (this.buttonTextField.width / 2);
			this.buttonTextField.y = (buttonSpriteHeight / 2) - (this.buttonTextField.height / 2);
			
			
			buttonSprite.graphics.beginFill(0x111111);
			buttonSprite.graphics.drawRect(0, 0, buttonSpriteWidth, buttonSpriteHeight);
			buttonSprite.graphics.endFill();
			
			buttonSprite.addChild( buttonTextField );

			this.buttonCanvas = canvasFactory.createCanvasFromSprite(buttonSprite);
		}
		
		public function getY():Number
		{
			return this.buttonCanvas.getY();
		}

		public function setX( x:Number ):void
		{
			this.buttonCanvas.setX( x );
		}
		
		public function setY( y:Number ):void
		{
			this.buttonCanvas.setY( y );
		}
		
		public function centerXPosition( x:Number ):void
		{
			this.buttonCanvas.setX( x - (this.buttonCanvas.getWidth() / 2));
		}
		
		public function getHeight():Number
		{
			return this.buttonCanvas.getHeight();
		}
		
		private function mouseUpEventHandler(event:MouseEvent):void
		{
			this.clickHandler.onClick( new ClickEvent( clickData, event ));
		}
		
		private function init(e:Event = null):void 
		{
			this.buttonTextField.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.buttonTextField.addEventListener(MouseEvent.MOUSE_UP, mouseUpEventHandler );
		}		
		
		public function getCanvas():ICanvas
		{
			return this.buttonCanvas;
		}
	}
	
}