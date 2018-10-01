package iface.client.presentation.level 
{
	import iface.common.domain.level.ILevel;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ILevelPresentationFactory 
	{
		function createLevelPresentation( level:ILevel ):ILevelPresentation;
	}
	
}