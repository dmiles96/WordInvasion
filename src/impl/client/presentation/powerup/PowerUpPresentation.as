package impl.client.presentation.powerup 
{
	import flash.display.CapsStyle;
    import flash.display.LineScaleMode;	
	import flash.display.Sprite;	
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;	
	import iface.client.presentation.powerup.IPowerUpPresentation;
	import iface.client.service.audio.IGameSound;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PowerUpPresentation 
	{
		private var powerUpCanvas:ICanvas = null;
		private var powerUpSound:IGameSound = null;
		private var textField:TextField = new TextField();
		
		public function PowerUpPresentation(canvasFactory:ICanvasFactory, powerUpWidth:int, powerUpHeight:int, powerUpSound:IGameSound, powerUpTextFormat:TextFormat, character:String) 
		{
			this.powerUpSound = powerUpSound;
			
			var powerUpSprite:Sprite = new Sprite();

			this.powerUpCanvas = canvasFactory.createCanvasFromSprite(powerUpSprite);
			
			this.textField.selectable = false;
			this.textField.embedFonts = true;
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			this.textField.type = TextFieldType.DYNAMIC;
			this.textField.text = character;
			this.textField.setTextFormat( powerUpTextFormat );
			this.textField.x = 0;
			this.textField.y = 0;
			
			this.getCanvas().addChild( textField );			
		}
		
		public function getCanvas():ICanvas
		{
			return this.powerUpCanvas;
		}
		
		public function playSound():void
		{
			this.powerUpSound.play();
		}
	}
	
}