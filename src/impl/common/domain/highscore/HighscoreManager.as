package impl.common.domain.highscore 
{
	import flash.net.registerClassAlias;
	import flash.net.SharedObject;
	import iface.common.domain.highscore.IHighscore;
	import iface.common.domain.highscore.IHighscoreFactory;
	import iface.common.domain.highscore.IHighscoreManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HighscoreManager implements IHighscoreManager
	{
		private var highscoreFactory:IHighscoreFactory = null;
		
		public function HighscoreManager( highscoreFactory:IHighscoreFactory ) 
		{
			this.highscoreFactory = highscoreFactory;
		}

		public function load():Array
		{
			var highscoreStorage:SharedObject = SharedObject.getLocal("highscores");
			
			if( highscoreStorage.data.database == null )
			{
				return this.createDefaultDatabase();
			}
			else
			{
				var serializedHighscores:Array = highscoreStorage.data.database as Array;
				var highscores:Array = new Array();
				
				for each( var serializedHighscore:Object in serializedHighscores )
				{
					highscores.push( this.highscoreFactory.createHighscore( serializedHighscore["name"], serializedHighscore["score"] ));
				}
				
				return highscores;
			}
		}
		
		public function save( highscores:Array ):void
		{
			var highscoreStorage:SharedObject = SharedObject.getLocal("highscores");
			
			var serializedHighscores:Array = new Array();
			
			for each( var highscore:IHighscore in highscores )
			{
				var serializedHighscore:Object = new Object();
				
				serializedHighscore["name"] = highscore.getName();
				serializedHighscore["score"] = highscore.getScore();
				serializedHighscores.push( serializedHighscore );
			}
			
			highscoreStorage.data.database = serializedHighscores;
			
			highscoreStorage.flush( 512 * 1024 );
		}
		
		private function createDefaultDatabase():Array
		{
			var highScoreDB:Array = new Array();
			
			highScoreDB.push( this.highscoreFactory.createHighscore( "LB", 20000 ));			
			highScoreDB.push( this.highscoreFactory.createHighscore( "MC", 9000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Miranda Louise", 8000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "E. \"Pace\" Estrada", 7000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Fredrico", 6000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Courtney G-O", 5000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Ang", 4000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Bushman", 3000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Haynes", 2000 ));
			highScoreDB.push( this.highscoreFactory.createHighscore( "Dav", 1000 ));
		
			return highScoreDB;
		}

	}
	
}