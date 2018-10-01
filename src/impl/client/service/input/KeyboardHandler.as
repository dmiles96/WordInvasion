package impl.client.service.input 
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import iface.client.service.input.CommandKeyNameDatabase;
	import iface.client.service.input.IKeyboardHandler;
	import iface.client.service.input.IKeyState;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.ICanvasFactory;
	import impl.client.service.video.Canvas;
	
	/**
	 * ...
	 * @author ...
	 */
	public class KeyboardHandler implements IKeyboardHandler
	{
		private var keyStates:Object = new Object();
		private var commandKeyNameDatabase:CommandKeyNameDatabase = null;
		
		public function KeyboardHandler(canvasFactory:ICanvasFactory, commandKeyNameDatabase:CommandKeyNameDatabase) 
		{
			this.commandKeyNameDatabase = commandKeyNameDatabase;
			
			var mainCanvas:ICanvas = canvasFactory.getMainCanvas();
			var mainSprite:Sprite = (mainCanvas as Canvas).getInternalSprite();
			
			mainSprite.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler, false, 0, true );
			mainSprite.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler, false, 0, true );
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			var newKeyState:IKeyState = null;

			if ( (e.charCode != 0) && (e.keyCode != 27))
			{
				newKeyState = new AlphaNumericKeyState(e.keyCode, e.charCode, true, e.shiftKey);
			}
			else
			{
				newKeyState = new CommandKeyState( this.commandKeyNameDatabase.getKeyNameForCode(e.keyCode), e.keyCode, e.charCode, true, e.shiftKey );
			}
			
			if ( keyStates[e.keyCode] == null )
			{
				keyStates[e.keyCode] = newKeyState;
			}
			else
			{
				keyStates[e.keyCode].press(e.charCode, e.shiftKey);
			}			
		}
		
		private function keyUpHandler(e:KeyboardEvent):void
		{
			if ( keyStates[e.keyCode] != null )
			{
				keyStates[e.keyCode].clear();
			}
		}
		
		public function getKeyStates():Object
		{
			return this.keyStates;
		}		
	}
	
}
