package impl.client.view 
{
	import flash.display.Sprite;
	import iface.client.presentation.IGamePresentation;
	import iface.client.presentation.IGamePresentationFactory;
	import iface.client.service.video.ICanvas;
	import iface.client.service.video.IRenderFactory;
	import iface.client.service.video.IUpdateableCanvas;
	import iface.client.service.video.IUpdateRegion;
	import iface.client.view.IGameView;
	import iface.client.service.video.ICanvasFactory;
	import iface.common.domain.IGame;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameView implements IGameView
	{
		private var gamePresentation:IGamePresentation = null;
		private var gameCanvas:IUpdateableCanvas = null;
		
		public function GameView(canvasFactory:ICanvasFactory, gamePresentationFactory:IGamePresentationFactory, game:IGame) 
		{
			this.gameCanvas = canvasFactory.createUpdateableCanvas()
			this.gamePresentation = gamePresentationFactory.createGamePresentation(game, gameCanvas);
		}
		
		public function getUpdateRegion():IUpdateRegion
		{
			return this.gameCanvas;
		}
		
		public function getCanvas():ICanvas
		{
			return gameCanvas;
		}
	}
	
}