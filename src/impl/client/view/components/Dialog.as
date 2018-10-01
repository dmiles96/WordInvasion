package impl.client.view.components 
{
	import flash.display.Sprite;
	import flash.display.CapsStyle;
    import flash.display.LineScaleMode;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.components.IDialog;
	import iface.client.view.components.IOnCloseHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Dialog implements IDialog
	{
		private var dialogCanvas:ICanvas = null;
		private var parentDrawingSurface:ICanvas = null;
		private var keyHandler:Function = null;
		private var location:Point = null;
		private var dialogTextField:TextField = new TextField();
		private var onCloseHandler:IOnCloseHandler = null;
		private var width:int = 0;
		private var height:int = 0;
		private var standardTextForamt:TextFormat = null;
		
		public function Dialog( canvasFactory:ICanvasFactory, location:Point, text:String, standardTextForamt:TextFormat, width:int, height:int, onCloseHandler:IOnCloseHandler = null ) 
		{
			this.location = location;
			this.keyHandler = keyHandler;
			this.onCloseHandler = onCloseHandler;
			this.width = width;
			this.height = height;
			this.standardTextForamt = standardTextForamt;
			
			var dialogSprite:Sprite = new Sprite();

			dialogSprite.addChild( dialogTextField );
			dialogSprite.graphics.lineStyle(4, 0xFFFFFF, 1.00, false, LineScaleMode.NONE, CapsStyle.NONE);
			dialogSprite.opaqueBackground = true;
			dialogSprite.graphics.drawRoundRect( 0, 0, width, height, 5, 5 );
			
			standardTextForamt.align = TextFormatAlign.CENTER;
			
			dialogTextField.selectable = false;
			dialogTextField.embedFonts = true;
			dialogTextField.type = TextFieldType.DYNAMIC;
			dialogTextField.text = text;
			dialogTextField.setTextFormat( standardTextForamt );
			dialogTextField.selectable = false;
			dialogTextField.width = width - 60;
			dialogTextField.wordWrap = true;

			this.positionDialogText();
			
			this.dialogCanvas = canvasFactory.createCanvasFromSprite( dialogSprite );
		}
		
		public function show( parentDrawingSurface:ICanvas ):void
		{
			this.parentDrawingSurface = parentDrawingSurface;
			
			this.parentDrawingSurface.addCanvas( this.dialogCanvas );
			
			this.dialogCanvas.setX( location.x );
			this.dialogCanvas.setY( location.y );
		}
		
		public function close():void
		{
			this.parentDrawingSurface.removeCanvas(this.dialogCanvas);
			
			if( this.onCloseHandler != null )
				this.onCloseHandler.onClose(this);
		}
		
		public function getDialogCanvas():ICanvas
		{
			return this.dialogCanvas;
		}
		
		public function getDialogTextField():TextField
		{
			return this.dialogTextField;
		}
		
		public function setText( newText:String ):void
		{
			dialogTextField.text = newText;
			dialogTextField.setTextFormat( standardTextForamt );

			this.positionDialogText();
		}
		
		public function getHeight():int
		{
			return this.height;
		}
		
		private function positionDialogText():void
		{
			dialogTextField.x = (this.width / 2 ) - (dialogTextField.width / 2);
			dialogTextField.y = (this.height / 3) - (dialogTextField.textHeight / 2);				
		}
	}
	
}