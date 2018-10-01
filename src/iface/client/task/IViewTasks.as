package iface.client.task 
{
	
	import iface.client.view.IView;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface IViewTasks 
	{
		function showView(view:IView):void;
		function removeView( view:IView ):void;
	}
	
}