public class FeedItemTriggerHandler { 
    /*
             Method Name: FeedVisiblity
             Purpose: To change the visiblity of feed item.
             Input Parameter : List of FeedItem
             Created Date: June 2016
             */
     public static void FeedVisiblity(List < FeedItem > newTrigger) {

        for (FeedItem NewFeed: newTrigger) {
           
                      NewFeed.Visibility = 'AllUsers';
                    
        }
    } 
  }