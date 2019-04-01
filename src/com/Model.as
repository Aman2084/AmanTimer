///////////////////////////////////////////////////////////
//  Model.as
//  Macromedia ActionScript Implementation of the Class Model
//  Created on:      2016-6-22 上午10:58:49
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package com
{
	import com.aman.event.ZEvent;
	import com.aman.utils.Utils;
	
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	/**
	 * 时间数据
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2016-6-22 上午10:58:49
	 */
	public class Model extends EventDispatcher
	{
		public static const State_Stop:int = 0;
		public static const State_Run:int = 1;
		public static const State_Pause:int = 2;
		
		private var _interval:Number;
		private var _time_start:Number
		private var _time_restart:Number
		private var _time_end:Number
		
		public var useCountDown:Boolean = false;
		public var numCountDown:int;
		
		private var _state:int = 0;
		private var _functionId:uint;
		
		public function Model(){
			_state = State_Stop;	
		}
		
//tools
		private function date2str($d:Date):String{
			var str:String = $d.toTimeString();
			var a:Array = str.split(" ");
			str = a[0]
			return str
		}
		
		private function onTime():void{
			var e:ZEvent = new ZEvent(ZEvent.Update);
			this.dispatchEvent(e);
		}
		
		private function setState($s:int):void{
			if(_state==$s){
				return
			}
			
			_state = $s;
			var e:ZEvent = new ZEvent(ZEvent.State);
			this.dispatchEvent(e);
		}
		
//interface
		public function start():void{
			if(state!=State_Stop){
				return
			}
			_time_start = _time_restart = Utils.getTimeStamp();
			_interval = 0;
			_functionId = setInterval(onTime , 1000);
			setState(State_Run);
		}
		
		public function pause():void{
			if(state!=State_Run){
				return
			}
			clearInterval(_functionId);
			_interval = interval;
			setState(State_Pause)
		}
		
		public function resume():void{
			if(state!=State_Pause){
				return
			}
			_time_restart = Utils.getTimeStamp();
			_functionId = setInterval(onTime , 1000);
			setState(State_Run);
		}
		
		public function stop():void{
			if(state==State_Stop){
				return
			}
			pause();
			setState(State_Stop);
		}
		
		/*public function isFuture(h:int, m:int, s:int):Boolean{
			var d1:Date = new Date();
			var d2:Date = new Date();
			d1.hours = h;
			d1.minutes = m;
			d1.seconds = s;
			var b:Boolean = d1.getTime()>d2.getTime();
			return b;
		}
		
		public function setTime(h:int, m:int, s:int):void{
			date.hours = h;
			date.minutes = m;
			date.seconds = s;
		}*/
		
		/**
		 * 为正式计时做准备
		public function init():void{
			var d:Date = new Date();
			_time_start = d.getTime();
			if(useCountDown){
				_time_end = _time_start + numCountDown * 1000;
			}else{
				_time_end = date.getTime();
			}
		}
		*/
		
//getter and setter
		
		/**
		 * 已经用掉的时间
		 * @return 
		 */
		public function get interval():Number{
			var n:Number = Utils.getTimeStamp() - _time_restart;;
			n += _interval
			return n;
		}

		public function get time_start():Number{
			return _time_start;
		}

		public function get state():int{
			return _state;
		}

		
	}
}