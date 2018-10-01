package impl.client.task 
{
	import iface.client.task.ITaskFactory;
	import iface.client.task.IViewTasks;
	import iface.client.service.video.ICanvasFactory;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TaskFactory implements ITaskFactory
	{
		
		private var viewTasks:IViewTasks = null;
		
		public function TaskFactory(canvasFactory:ICanvasFactory) 
		{
			 this.viewTasks = new ViewTasks(canvasFactory);
		}
		
		public function getViewTasks():IViewTasks
		{
			return this.viewTasks;
		}
	}
	
}