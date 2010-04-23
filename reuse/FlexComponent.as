package com.bluecoat.containers
{
	/**
	 * BCPanel is a lightweight static container
	 * without any interactivity, or effects
	 * It is intended to replace BCWindowShadeOpen
	 * which is tightly coupled BCWindowShade
	 * whereas BCPanel is intended to allow more flexibility
	 * of styling while avoing cruft/ issues with interactive
	 * code inherited from BCWindowShade. 
	 * It does not permit resizing, or effects
	 * currently only box layout is implemented
	 * also it isn't disable-able
	 */
	
	//--------------------------------------
	//  Styles
	//--------------------------------------

	//--------------------------------------
	//  Excluded APIs
	//--------------------------------------

public class BCPanel extends Container
	{

		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------

		/**
		 * Constructor
		 */
		public function BCPanel()
		{
			super();
		}
		
		/**
		 * @public
		 */
		
		/**
		 * Initialization phase methods:
		 * 1.createChildren()
		 * 2.childrenCreated()
		 * 3.initializeAccessibility()
		 * 4.initializationComplete()
		 * these are called by the intialize() method
		 * which should not be overriden directly.
		 * Note that FlexEvent.PREINITIALIZE event
		 * is fired at the start of initialize()
		 * before any of the sub-methods below
		 * This is the last opportunity before children are created
		 */
		override protected function createChildren():void
		{
			super.createChildren();
		}
		/**
		 * childrenCreated() 
		 * calls the first invalidation sequence:
		 * all invalidation methods are called,
		 * and initialized is set to true after this
		 */
		override protected function childrenCreated():void
		{
			super.childrenCreated();
		}

		override protected function initializeAccessibility():void
		{
			super.initializeAccessibility();
		}
		/*
		 * this is the last method called in initialize()
		 * it fires the FlexEvent.INITIALIZED event
		 */
		override protected function initializationComplete():void
		{
			super.initializationComplete();
		}

		/*
		 * Validation phase methods
		 * called after Event.RENDER, just before
		 * display list is rendered
		 * 1.commitProperties()
		 * 2.measure()
		 * 3.layoutChrome() //for a Container
		 * 4.updateDisplayList()
		 */

		/**
		 * Initialize: Step 1
		 */
		override protected function commitProperties():void
		{
			super.commitProperties();
		}
		
		/**
		 * Initialize: Step 2
		 */
		override protected function measure():void
		{
			super.measure();
		}       

		/**
		 * Initialize: Step 3
		 */
		override protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void
		{
			trace("layoutChrome");
		}

		/**
		 * Initialize: Step 4
		 */
        override protected function updateDisplayList(w:Number, h:Number):void {
            super.updateDisplayList(w, h);
		}

		/**
		 *  styleChanged is called when any style is changed
		 */
		override public function styleChanged(styleProp:String):void
		{
			trace("styleChanged("+styleProp+")");

		}

		//--------------------------------------------------------------------------
		//
		//  Methods - Utility
		//
		//--------------------------------------------------------------------------

	}
}
