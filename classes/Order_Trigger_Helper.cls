global with sharing class Order_Trigger_Helper {
 
 	public static boolean futureMethodRunning = false;
 
	global class OrderStageAggregate 
	{
		public Order o;
		public boolean orderNeedsUpdating = false;
		public boolean mfrOrdersNeedUpdating = false;
		public boolean shippingOrdersNeedUpdating = false;
		public Order oldO;
		public list<Manufacturing_Order__c> manufacturingOrders;
		public list<Shipping_Order__c> shippingOrders;
	}
	

  	@future 
 	public static void doShippingOrderUpdates( list<Id> orderids) 
	{ 

		futureMethodRunning = true;
		
		map<Id, list<Manufacturing_Order__c>> manufacturingOrderMap = new map<Id, list<Manufacturing_Order__c>>();
		map<Id, list<Shipping_Order__c>> shippingOrderMap = new map<Id, list<Shipping_Order__c>>();
		
		for( Manufacturing_Order__c mo : [SELECT Id, Order__c, Factory_Completion_Date__c, Status__c, Work_Order_Sent__c,Work_Order_Received__c FROM Manufacturing_Order__c WHERE Order__c = :orderids ])
		{
			if( !manufacturingOrderMap.containsKey( mo.Order__c) )
			{
				manufacturingOrderMap.put( mo.Order__c, new list<Manufacturing_Order__c>() );
			}
			manufacturingOrderMap.get(mo.Order__c).add( mo );
						
		}		
		for( Shipping_Order__c so : [SELECT Id,Order__c, Status__c, Actual_Pickup_Date__c,Actual_Delivery_Date__c FROM Shipping_Order__c WHERE Order__c = :orderIds ])
		{
			if( !shippingOrderMap.containsKey( so.Order__c) )
			{
				shippingOrderMap.put( so.Order__c, new list<Shipping_Order__c>() );
			}
			shippingOrderMap.get(so.Order__c).add( so );
		}
		
		 
		list<Order> orders = [SELECT Id, Status, Order_Finalized_Date__c, Balance_Received_Date__c, Stage__c FROM Order WHERE Id = :orderids];
		list<Shipping_Order__c> shippingOrdersToUpdate = new list<Shipping_Order__c>();
		list<Order> ordersToUpdate = new list<Order>();
		for( Order o : orders )
		{
//			if( o.Stage__c != 'On Hold'
//				&& o.Stage__c != 'Cancelled')
			{
				Order_Trigger_Helper.OrderStageAggregate osa = new Order_Trigger_Helper.OrderStageAggregate();
				osa.o = o;
				osa.oldO = o;
				osa.manufacturingOrders = manufacturingOrderMap.get( o.Id );
				osa.shippingOrders = shippingOrderMap.get( o.Id );
				
				Order_Trigger_Helper.SetStages( osa );
				if(  osa.shippingOrdersNeedUpdating)
				{
					 shippingOrdersToUpdate.addAll( osa.shippingOrders);
				}

			}
		}
		
		if(shippingOrdersToUpdate.size() > 0 )
			update shippingOrdersToUpdate;
				
	}
 
 	@future
 	public static void doMfrOrderUpdates( list<Id> orderids) 
	{
		futureMethodRunning = true;
		
		map<Id, list<Manufacturing_Order__c>> manufacturingOrderMap = new map<Id, list<Manufacturing_Order__c>>();
		map<Id, list<Shipping_Order__c>> shippingOrderMap = new map<Id, list<Shipping_Order__c>>();
		
		for( Manufacturing_Order__c mo : [SELECT Id, Order__c, Factory_Completion_Date__c, Status__c, Work_Order_Sent__c,Work_Order_Received__c FROM Manufacturing_Order__c WHERE Order__c = :orderids ])
		{
			if( !manufacturingOrderMap.containsKey( mo.Order__c) )
			{
				manufacturingOrderMap.put( mo.Order__c, new list<Manufacturing_Order__c>() );
			}
			manufacturingOrderMap.get(mo.Order__c).add( mo );
						
		}		
		for( Shipping_Order__c so : [SELECT Id,Order__c, Status__c, Actual_Pickup_Date__c,Actual_Delivery_Date__c FROM Shipping_Order__c WHERE Order__c = :orderIds ])
		{
			if( !shippingOrderMap.containsKey( so.Order__c) )
			{
				shippingOrderMap.put( so.Order__c, new list<Shipping_Order__c>() );
			}
			shippingOrderMap.get(so.Order__c).add( so );
		}
		
		 
		list<Order> orders = [SELECT Id, Status, Order_Finalized_Date__c, Balance_Received_Date__c, Stage__c FROM Order WHERE Id = :orderids];
		list<Manufacturing_Order__c> manufacturingOrdersToUpdate = new list<Manufacturing_Order__c>();
		list<Order> ordersToUpdate = new list<Order>();
		for( Order o : orders )
		{
//			if( o.Stage__c != 'On Hold'
//				&& o.Stage__c != 'Cancelled')
			{
				Order_Trigger_Helper.OrderStageAggregate osa = new Order_Trigger_Helper.OrderStageAggregate();
				osa.o = o;
				osa.oldO = o;
				osa.manufacturingOrders = manufacturingOrderMap.get( o.Id );
				osa.shippingOrders = shippingOrderMap.get( o.Id );
				
				Order_Trigger_Helper.SetStages( osa );
				if(  osa.mfrOrdersNeedUpdating)
				{
					 manufacturingOrdersToUpdate.addAll( osa.manufacturingOrders);
				}

			}
		}
		
		if(manufacturingOrdersToUpdate.size() > 0 )
			update manufacturingOrdersToUpdate	;
				
	}
 
 	@future
 	public static void doOrderUpdates( list<Id> orderids) 
 	{
		futureMethodRunning = true;
				
		map<Id, list<Manufacturing_Order__c>> manufacturingOrderMap = new map<Id, list<Manufacturing_Order__c>>();
		map<Id, list<Shipping_Order__c>> shippingOrderMap = new map<Id, list<Shipping_Order__c>>();
		
		for( Manufacturing_Order__c mo : [SELECT Id, Order__c, Factory_Completion_Date__c, Status__c, Work_Order_Sent__c, Work_Order_Received__c FROM Manufacturing_Order__c WHERE Order__c = :orderids ])
		{
			if( !manufacturingOrderMap.containsKey( mo.Order__c) )
			{
				manufacturingOrderMap.put( mo.Order__c, new list<Manufacturing_Order__c>() );
			}
			manufacturingOrderMap.get(mo.Order__c).add( mo );
		} 
		
		for( Shipping_Order__c so : [SELECT Id,Order__c, Status__c, Actual_Pickup_Date__c,Actual_Delivery_Date__c FROM Shipping_Order__c WHERE Order__c = :orderids ])
		{
			if( !shippingOrderMap.containsKey( so.Order__c) )
			{
				shippingOrderMap.put( so.Order__c, new list<Shipping_Order__c>() );
			}
			shippingOrderMap.get(so.Order__c).add( so );
		}
		
		
		list<Order> orders = [SELECT Id, Status, Order_Finalized_Date__c, Balance_Received_Date__c, Stage__c FROM Order WHERE Id = :orderids];
		
		list<Order> ordersToUpdate = new list<Order>();
		for( Order o : orders )
		{
			if( o.Stage__c != 'On Hold'
				&& o.Stage__c != 'Cancelled')
			{			
				Order_Trigger_Helper.OrderStageAggregate osa = new Order_Trigger_Helper.OrderStageAggregate();
				osa.o = o;
				osa.oldO = o;
				osa.manufacturingOrders = manufacturingOrderMap.get( o.Id );
				osa.shippingOrders = shippingOrderMap.get( o.Id );
				
				Order_Trigger_Helper.SetStages( osa );
				if( osa.orderNeedsUpdating ) 
				{
					ordersToUpdate.add(o);
				}

			}
		}
		
		if(ordersToUpdate.size() > 0  )
			update ordersToUpdate;
		
 	}
 
 	public static OrderStageAggregate SetStages(OrderStageAggregate input) 
 	{
 	
 	
 		if( input.manufacturingOrders == null || input.shippingOrders == null  )
 		{
 			//backfill necessity
 			return input;
 		}
 	
 		System.debug('Order State: ' + input.o.Stage__c + ' / ' + input.o.Status);
 		//7. manually select O.stage="on hold"
			// If unselect "On Hold", all W.O. and S.O. return to stage from above rules
  		if( input.o.Stage__c == 'On Hold' || input.o.Status == 'On Hold')
  		{ //i think this means do nothing
  			system.debug('On Hold');
   			for( Manufacturing_Order__c mo: input.manufacturingOrders ) 
  			{
  				mo.Status__c = 'On Hold';
  				input.mfrOrdersNeedUpdating = true;
  			}
  			for( Shipping_Order__c so: input.shippingOrders )
  			{
  				so.Status__c = 'On Hold';
  				input.shippingOrdersNeedUpdating = true;
  			}
  			
  			return input;
  		} else if( input.o.Stage__c == 'Cancelled' || input.o.Status == 'Cancelled')
  		{
  			//8. "manually select O.stage=""cancelled""
 			//All W.O. and S.O. set to ""cancelled""
 			system.debug('cancelled');
   			for( Manufacturing_Order__c mo: input.manufacturingOrders ) 
  			{
  				mo.Status__c = 'Cancelled';
  				input.mfrOrdersNeedUpdating = true;
  			}
  			for( Shipping_Order__c so: input.shippingOrders )
  			{
  				so.Status__c = 'Cancelled';
  				input.shippingOrdersNeedUpdating = true;
  			}
  			return input;
  		}
  		 		
 		//1a. O.OrderFinalizedDate <> NULL
system.debug( 'Order Finalized: ' + input.o.Order_Finalized_Date__c + ' && ' + input.oldO.Order_Finalized_Date__c  ); 		
 		if( input.o.Order_Finalized_Date__c != null && input.oldO.Order_Finalized_Date__c == null )
		{ 
			system.debug('order finalized date changing');
			input.o.Stage__c = 'Finalized';
			input.o.Status = 'Finalized';
			input.orderNeedsUpdating = true;
		} 
		
		for( Manufacturing_Order__c mo : input.manufacturingOrders )
		{
			if( mo.Factory_Completion_Date__c != null )
			{
				//2a. "For W.O.: FactoryCompletionDate <> """"
				mo.Status__c = 'Factory Complete';
				input.mfrOrdersNeedUpdating = true;
			} else if( mo.Work_Order_Sent__c != null )
			{
				//1b. W.O. "WorkOrderSent" <> NULL
				mo.Status__c = 'Work Order Sent';
				input.mfrOrdersNeedUpdating = true;
			} else if( mo.Work_Order_Received__c != null )
			{
				//not in spec, adding as per email on 5/16/16
				mo.Status__c = 'Work Order Received';
				input.mfrOrdersNeedUpdating = true;
			} 
		
		}
		
		//2b. For O: all W.O. have ""factory complete"""
		boolean allMfrOrderFactoryComplete = true;
		for( Manufacturing_Order__c mo : input.manufacturingOrders )
 		{
system.debug('MFR ORDER STATUS: ' + mo.Status__c); 			
 			if(mo.Status__c != 'Factory Complete')
 			{
 				allMfrOrderFactoryComplete = false;
// 				break;
 			}
 		}
system.debug('mfrorderfactorycomplete ' + allMfrOrderFactoryComplete); 		
 		
 		if(allMfrOrderFactoryComplete == true)
 		{
system.debug( 'mfrorderfactorycomplete is ' + allMfrOrderFactoryComplete); 			
 			input.o.Stage__c = 'Factory Complete';
 			input.o.Status = 'Factory Complete';
 			input.orderNeedsUpdating = true;
 		}
		
		//recursion problems below here
		for( Shipping_Order__c so : input.shippingOrders ) 
		{
			if( so.Actual_Delivery_Date__c != null )
			{
				//5.  ActualDeliveryDate <> NULL
				so.Status__c = 'Delivered';
				input.shippingOrdersNeedUpdating = true;
				/*
			} else if(input.o.Balance_Received_Date__c != null 
				&& so.Actual_Delivery_Date__c == null )
			{
				//4. Balance Received Date <> NULL AND
				//	 ActualDeliveryDate = NULL for any S.O.
				so.Status__c = 'Paid/Not Delivered';
				input.shippingOrdersNeedUpdating = true;
				*/
			} else if( so.Actual_Pickup_Date__c != null )
			{
				//3a. "For S.O.:  ""ActualPickupDate"" <> NULL
				so.Status__c = 'Shipped';
				input.shippingOrdersNeedUpdating = true;
			}
		
		}
		
		//3b.  For O: All S.O. are "shipped"
		//5.  For O: All S.O. are "shipped"
		boolean allShipOrdersShipped = true;
		boolean allShipOrdersDelivered = true;
		boolean actualDeliveryDateNull = false;
		
		for( Shipping_Order__c so : input.shippingOrders )
 		{
system.debug('ship order status = ' + so.Status__c + ' ; allShipOrdersShipped = '+allShipOrdersShipped+' ; allShipOrdersDelivered = ' +allShipOrdersDelivered); 			


			if( so.Actual_Delivery_Date__c == null )
 			{
 				actualDeliveryDateNull = true;
 			} 
 			
 			if(so.Status__c != 'Shipped' )
 			{
 				allShipOrdersShipped = false;
 			}
 			
 			if(so.Status__c != 'Delivered' )
 			{
 				allShipOrdersDelivered = false;
 			}
 		}
 		if( allShipOrdersDelivered )
 		{
 			input.o.Stage__c = 'Delivered'; 			
 			input.o.Status = 'Delivered';
 			input.orderNeedsUpdating = true;
 		} else if(allShipOrdersShipped)
 		{
 			input.o.Stage__c = 'Shipped';
			input.o.Status = 'Shipped'; 			
 			input.orderNeedsUpdating = true;
 		}
		
		//6. O.BalanceReceivedDate<> NULL		
		if(input.o.Balance_Received_Date__c != null && actualDeliveryDateNull)
		{
			input.o.Stage__c = 'Paid/Not Delivered';
			input.o.Status = 'Paid/Not Delivered';
			input.orderNeedsUpdating = true;
		} else if( input.o.Balance_Received_Date__c != null  ) //&& input.oldO.Balance_Received_Date__c == null
		{
			input.o.Stage__c = 'Paid/Delivered';
			input.o.Status = 'Paid/Delivered';
			input.orderNeedsUpdating = true;
		}

				
			
 		return input;
 	}
    
}