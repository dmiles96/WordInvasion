package iface.client.view 
{
	import iface.common.domain.IGame;

	/**
	 * ...
	 * @author ...
	 */
	public interface IViewFactory 
	{
		function createGameMenuView(playButtonClickHandler:IClickHandler, viewHighscoresButtonClickHandler:IClickHandler):IView;
		function createGameView(game:IGame):IGameView;
		function createHighscoreView(continueButtonClickHandler:IClickHandler):IHighscoreView;
	}
	
}