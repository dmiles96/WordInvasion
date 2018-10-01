package iface.common.domain.dictionary 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IDictionary 
	{
		function lookupRandomWord( indexChar:String ):String;
		function contains( indexChar:String ):Boolean;
	}
	
}