/**
 * User: Sol23
 */
package robotlegs.bender.extensions.simpleViewExtension {
	import robotlegs.bender.extensions.simpleViewExtension.api.IView;
	import robotlegs.bender.extensions.viewProcessorMap.api.IViewProcessorMap;
	import robotlegs.bender.extensions.viewProcessorMap.impl.ViewInjectionProcessor;
	import robotlegs.bender.framework.api.IConfig;

	public class SimpleViewConfig implements IConfig {

		[Inject]
		public var viewProcessor:IViewProcessorMap;

		public function configure():void {
			viewProcessor.map(IView).toProcess(ViewInjectionProcessor);
		}
	}
}
