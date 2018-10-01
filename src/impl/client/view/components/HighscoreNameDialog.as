package impl.client.view.components 
{
	import flash.display.Sprite;
	import flash.display.CapsStyle;
    import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;	
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.ClickEvent;
	import iface.client.view.components.IHighscoreNameDialog;
	import iface.client.view.components.IOnCloseHandler;
	import iface.client.view.IClickHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HighscoreNameDialog extends Dialog implements IClickHandler, IHighscoreNameDialog
	{
		private var nameTextField:TextField = new TextField();
		private var doneButton:Button = null;
		private var defaultText:String = "Player";
		private var name:String = null;
		
		public function HighscoreNameDialog(canvasFactory:ICanvasFactory, location:Point, standardTextFormat:TextFormat, width:int, height:int, onCloseHandler:IOnCloseHandler, highscoreFieldMargin:int, playAreaWidth:int )  
		{
			super( canvasFactory, location, "New high score! Please type your name:", standardTextFormat, width, height + 20, onCloseHandler );

			var dialogTextField:TextField = this.getDialogTextField();
			
			dialogTextField.y = (height / 4) - (dialogTextField.textHeight / 2);
			
			var nameTextFieldSprite:Sprite = new Sprite();
			var dialogMidPoint:int = location.x + (width / 2);
			var nameTextFieldWidth:int = (playAreaWidth / 2) - (highscoreFieldMargin * 2);
			
			nameTextField.selectable = true;
			nameTextField.embedFonts = true;
			nameTextField.autoSize = TextFieldAutoSize.LEFT;
			nameTextField.type = TextFieldType.INPUT;
			nameTextField.maxChars = 16
			nameTextField.width = nameTextFieldWidth;
			nameTextField.text = defaultText;
			nameTextField.setTextFormat(standardTextFormat);
			nameTextField.setSelection(0, defaultText.length);
			nameTextField.y = 2;
			
			nameTextFieldSprite.graphics.lineStyle(4, 0xFFFFFF, 1.00, false, LineScaleMode.NONE, CapsStyle.NONE);
			nameTextFieldSprite.graphics.drawRect( 0, 0, nameTextFieldWidth, nameTextField.height + 4);
			nameTextFieldSprite.x = dialogMidPoint - (nameTextFieldWidth / 2);
			nameTextFieldSprite.y = (dialogTextField.height / 2) + 20;
			
			this.doneButton = new Button( canvasFactory, "Done" ,  this, standardTextFormat, "highscores-name-done");
			this.doneButton.setY(nameTextFieldSprite.y + nameTextField.height + 20);
			this.doneButton.centerXPosition(playAreaWidth / 2);

			nameTextFieldSprite.addChild(nameTextField);
			this.getDialogCanvas().addCanvas( canvasFactory.createCanvasFromSprite(nameTextFieldSprite) );
			this.getDialogCanvas().addCanvas( doneButton.getCanvas() );
			
			this.nameTextField.addEventListener(Event.ADDED_TO_STAGE, setNameTextFieldFocus);
		}
		
		public function setNameTextFieldFocus(e:Event = null):void 
		{
			this.nameTextField.removeEventListener(Event.ADDED_TO_STAGE, setNameTextFieldFocus);
			this.nameTextField.stage.focus = this.nameTextField;
		}
		
		public function onClick(event:ClickEvent):void
		{
			this.name = this.nameTextField.text;
			this.close();
		}
		
		public function getName():String
		{
			return this.name;
		}
		
	}
	
}