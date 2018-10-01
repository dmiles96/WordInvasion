package impl.client.workflow 
{
	import iface.client.configuration.IApplicationConfiguration;
	import iface.client.service.input.CommandKeyNameDatabase;
	import iface.client.service.input.IKeyState;
	import iface.client.service.input.KeyStateTypes;
	import iface.common.scope.ISessionScope;
	import iface.common.domain.CommandTypes;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ProcessInputWorkflow 
	{
		private var appConfig:IApplicationConfiguration = null;
		
		public function ProcessInputWorkflow(appConfig:IApplicationConfiguration) 
		{
			this.appConfig = appConfig;
		}

		public function processInput( gameSession:ISessionScope, keyStates:Object ):void
		{
			for each( var keyState:IKeyState in keyStates )
			{
				if ( keyState.isPressed() && !keyState.isScanned() )
				{
					if ( keyState.getType() == KeyStateTypes.ALPHANUMERIC_KEY )
					{
						gameSession.getGameTimeline().getGame().inputAlphaNumeric( keyState.scanForChar() );
					}
					else if ( keyState.getType() == KeyStateTypes.COMMAND_KEY )
					{
						var command:int = -1;
			
						if ( keyState.scanForChar() == CommandKeyNameDatabase.F1_KEY )
						{
							command = CommandTypes.USE_POWERUP_ONE_COMMAND;
						}
						else if ( keyState.scanForChar() == CommandKeyNameDatabase.F2_KEY )
						{
							command = CommandTypes.USE_POWERUP_TWO_COMMAND;
						}
						else if ( keyState.scanForChar() == CommandKeyNameDatabase.F3_KEY )
						{
							command = CommandTypes.USE_POWERUP_THREE_COMMAND
						}
						else if ( keyState.scanForChar() == CommandKeyNameDatabase.ESC )
						{
							command = CommandTypes.PAUSE_COMMAND;
						}
						
						if( command != -1 )
							gameSession.getGameTimeline().getGame().inputCommand( command );
					}
				}
			}
		}
	}
	
}