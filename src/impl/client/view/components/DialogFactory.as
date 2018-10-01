package impl.client.view.components 
{
	import flash.geom.Point;
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.service.video.ICanvasFactory;
	import iface.client.view.components.IDialog;
	import iface.client.view.components.IDialogFactory;
	import iface.client.view.components.IGamePauseDialog;
	import iface.client.view.components.IHighscoreNameDialog;
	import iface.client.view.components.ILevelStartDialog;
	import iface.client.view.components.IOnCloseHandler;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DialogFactory implements IDialogFactory
	{
		private var canvasFactory:ICanvasFactory = null;
		private var appConfig:IApplicationConfiguration = null;
		
		public function DialogFactory( canvasFactory:ICanvasFactory, appConfig:IApplicationConfiguration ) 
		{
			this.canvasFactory = canvasFactory;
			this.appConfig = appConfig;
		}
		
		public function createLevelWonDialog(location:Point, width:int, height:int):IDialog
		{
			return new LevelWonDialog( this.canvasFactory, location, this.appConfig.getStandardCharacterFormat(), width, height );
		}
		
		public function createLevelLostDialog(location:Point, width:int, height:int):IDialog
		{
			return new LevelLostDialog( this.canvasFactory, location, this.appConfig.getStandardCharacterFormat(), width, height );
		}

		public function createGamePausedDialog(location:Point, width:int, height:int, volume:int):IGamePauseDialog
		{
			return new GamePauseDialog( this.canvasFactory, location, this.appConfig.getStandardCharacterFormat(), width, height, volume );
		}
		
		public function createHighscoreNameDialog(location:Point, width:int, height:int, onCloseHandler:IOnCloseHandler):IHighscoreNameDialog
		{
			return new HighscoreNameDialog( this.canvasFactory, location, this.appConfig.getStandardCharacterFormat(), width, height, onCloseHandler, this.appConfig.getHighscoreFieldMargin(), this.appConfig.getPlayAreaWidth() );
		}
		
		public function createLevelStartDialog(location:Point, width:int, height:int):ILevelStartDialog
		{
			return new LevelStartDialog( this.canvasFactory, location, this.appConfig.getStandardCharacterFormat(), width, height );
		}		
	}
	
}