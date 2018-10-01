package impl.client.view 
{
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.presentation.IGamePresentationFactory;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.IClickHandler;
	import iface.client.view.IGameView;
	import iface.client.view.IHighscoreView;
	import iface.client.view.IView;
	import iface.client.view.IViewFactory;
	import iface.common.domain.IGame;
	import impl.client.view.components.Button;
	
	
	/**
	 * ...
	 * @author ...
	 */
	public class ViewFactory implements IViewFactory
	{
		private var canvasFactory:ICanvasFactory = null;
		private var gamePresentationFactory:IGamePresentationFactory = null;
		private var appConfig:IApplicationConfiguration = null;
		
		public function ViewFactory(canvasFactory:ICanvasFactory, gamePresentationFactory:IGamePresentationFactory, appConfig:IApplicationConfiguration) 
		{
			this.canvasFactory = canvasFactory;
			this.gamePresentationFactory = gamePresentationFactory;
			this.appConfig = appConfig;
		}
		
		public function createGameMenuView(playButtonClickHandler:IClickHandler, viewHighscoresButtonClickHandler:IClickHandler):IView
		{
			return new GameMenuView(canvasFactory, playButtonClickHandler, viewHighscoresButtonClickHandler, 
									this.appConfig.getStandardCharacterFormat(), this.appConfig.getPlayAreaWidth(), this.appConfig.getPlayAreaHeight(), this.appConfig.getGameTitleTextFormat());
		}
		
		public function createGameView(game:IGame):IGameView
		{
			return new GameView(canvasFactory, gamePresentationFactory, game);
		}
		
		public function createHighscoreView(continueButtonClickHandler:IClickHandler):IHighscoreView
		{
			return new HighscoreView( canvasFactory, this.appConfig.getPlayAreaWidth(), this.appConfig.getPlayAreaHeight(), this.appConfig.getHighscoreFieldMargin(), this.appConfig.getHighscoreFieldPadding(), continueButtonClickHandler, this.appConfig.getStandardCharacterFormat() );
		}
	}
	
}