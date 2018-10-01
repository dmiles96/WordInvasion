package iface.client.view.components 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IDialogFactory 
	{
		function createLevelWonDialog(location:Point, width:int, height:int):IDialog;
		function createLevelLostDialog(location:Point, width:int, height:int):IDialog;
		function createGamePausedDialog(location:Point, width:int, height:int, volume:int):IGamePauseDialog;
		function createHighscoreNameDialog(location:Point, width:int, height:int, onCloseHandler:IOnCloseHandler):IHighscoreNameDialog;
		function createLevelStartDialog(location:Point, width:int, height:int):ILevelStartDialog;
	}
	
}